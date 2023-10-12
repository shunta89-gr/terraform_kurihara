from google.cloud import storage
import glob
import os
import zipfile
import shutil

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
            z.extract(info,'/tmp/')
        
        if os.path.isdir(z.infolist()[0].filename):
            return '/tmp/'+z.infolist()[0].filename
        else:
            return '/tmp/'

def upload_to_gcs(storage_client, bucket_name, unzip_dir):
    files = glob.glob(unzip_dir+'*.csv')
    for f in files:
        bucket = storage_client.get_bucket(bucket_name)
        blob = bucket.blob(os.path.basename(f))
        blob.upload_from_filename(f)
        os.remove(f)
    
def execute(cloud_event):
    #パラメータよりbucket_name
    request_args = cloud_event.args
    request_json = cloud_event.get_json(silent=True)
    file_encoding = 'utf-8'
    zip_encoding = 'utf-8'
    if request_args and 'bucket_name' in request_args:
        bucket_name = request_args.get('bucket_name')
        if 'zip_encodig' in request_args:
            zip_encoding = request_args.get('zip_encodig')
    elif request_json and 'bucket_name' in request_json:
        bucket_name = request_json.get('bucket_name')
        if 'zip_encodig' in request_json:
            zip_encoding = request_json.get('zip_encodig')
    else:
        return "パラメータの指定に誤りがあります", 400
    
    storage_client = storage.Client()
    
    zip_file_name = gcs_search(storage_client, bucket_name)
    if zip_file_name is None:
        return "対象のzipファイルが存在しませんでした", 200
    
    download(storage_client, bucket_name, zip_file_name)
    unzip_dir = unzip(zip_file_name, zip_encoding)
    upload_to_gcs(storage_client, bucket_name, unzip_dir)
    
    os.remove('/tmp/'+zip_file_name)
    shutil.rmtree(unzip_dir)
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(zip_file_name)
    blob.delete()