from google.cloud import storage
import glob
import os
import zipfile
from datetime import datetime, timedelta, timezone
import functions_framework

def gcs_search(storage_client, bucket_name):
    blobs = storage_client.list_blobs(bucket_name)
    zip_file_name = None
    for blob in blobs:
        if ('.zip' in blob.name):
            zip_file_name = blob.name
            break
    
    return zip_file_name

def download(storage_client, bucket_name, file_name):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob.download_to_filename('/tmp/'+file_name)

def unzip(file_name, zip_encoding='utf-8'):
    with zipfile.ZipFile('/tmp/'+file_name) as z:
        for info in z.infolist():
            info.filename = info.orig_filename.encode('CP437').decode(zip_encoding)
            if os.sep != "/" and os.sep in info.filename:
                info.filename = info.filename.replace(os.sep, "/")
            print(info.filename)
            z.extract(info,'/tmp/')
        
        buf = z.infolist()[0].filename.split('/')
        if '.csv' not in buf[0]:
            return '/tmp/'+z.infolist()[0].filename
        else:
            return '/tmp/'

def upload_to_gcs(storage_client, bucket_name, unzip_dir):
    files = glob.glob(unzip_dir+'*.csv')
    print(files)
    for f in files:
        bucket = storage_client.get_bucket(bucket_name)
        blob = bucket.blob(os.path.basename(f))
        blob.upload_from_filename(f)
        os.remove(f)

def buckup_from_gcs(storage_client, bucket_name, file_name, backup_bucket_name):
    source_bucket = storage_client.bucket(bucket_name)
    source_blog = source_bucket.blob(file_name)
    destination_bucket = storage_client.bucket(backup_bucket_name)
    JST = timezone(timedelta(hours=+9), 'JST')
    dt_now = datetime.now(JST)
    str_today = dt_now.strftime("%Y%m%d")
    
    destination_blob_name = "{}/{}".format(str_today, file_name)
    destination_generation_match_precondition = 0
    
    blob_copy = source_bucket.copy_blob(
        source_blog, destination_bucket, destination_blob_name, 
        if_generation_match=destination_generation_match_precondition,
    )
    source_bucket.delete_blob(file_name)
    
@functions_framework.http
def execute(request):
    #パラメータよりbucket_name
    request_args = request.args
    request_json = request.get_json(silent=True)
    file_encoding = 'utf-8'
    zip_encoding = 'utf-8'
    if request_args and 'bucket_name' in request_args and 'backup_bucket_name' in request_args:
        bucket_name = request_args.get('bucket_name')
        backup_bucket_name = request_args.get('backup_bucket_name')
        if 'zip_encodig' in request_args:
            zip_encoding = request_args.get('zip_encodig')
    elif request_json and 'bucket_name' in request_json and 'backup_bucket_name' in request_json:
        bucket_name = request_json.get('bucket_name')
        backup_bucket_name = request_json.get('backup_bucket_name')
        if 'zip_encodig' in request_json:
            zip_encoding = request_json.get('zip_encodig')
    else:
        return "パラメータの指定に誤りがあります", 400
    
    storage_client = storage.Client()
    
    zip_file_name = gcs_search(storage_client, bucket_name)
    if zip_file_name is None:
        return "対象のzipファイルが存在しませんでした", 404
    print("対象zipfile: {}".format(zip_file_name))
    print("ダウンロード処理開始")
    download(storage_client, bucket_name, zip_file_name)
    print("ダウンロード処理終了")
    print("unzip処理開始")
    unzip_dir = unzip(zip_file_name, zip_encoding)
    print("unzip処理終了 {}".format(unzip_dir))
    print("アップロード処理開始")
    upload_to_gcs(storage_client, bucket_name, unzip_dir)
    print("アップロード処理終了")
    buckup_from_gcs(storage_client, bucket_name, zip_file_name, backup_bucket_name)
    
    return "zip解凍処理完了",200