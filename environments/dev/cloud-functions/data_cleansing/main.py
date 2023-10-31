from google.cloud import storage
from google.cloud.storage.retry import DEFAULT_RETRY
from google.api_core.exceptions import NotFound
from util import Util
import io
import pandas as pd

chunk_size = 10000
_BACKOFF_DURATION = 200

# gcsからファイルをダウンロード
def download_file(storage_client, bucket_name, file_name, encoding):
    try:
        bucket = storage_client.get_bucket(bucket_name)
        blob = bucket.blob(file_name)
        blob = blob.download_as_text(encoding=encoding)
        buf = file_name.split("/")
        temp_file = "/tmp/{}".format(buf[-1])

        with open(temp_file, mode='wb') as fs:
            fs.write(blob.encode('utf-8'))
            fs.flush()
        
        return temp_file, 200
    except NotFound:
        return "ファイルが見つかりませんでした: {}".format(file_name), 200
    except Exception as e:
        return "ファイルのダウンロード中にエラーが発生しました: {}".format(e), 500

# ファイルの変換処理
def convert_file(file_path, delimiter=','):
    chunks = pd.read_csv(file_path, chunksize=chunk_size, header=None, na_filter=False, dtype=str)
    for chunk in chunks:
        lines = []
        for buf in chunk.to_numpy():
            file_name = Util.get_filename_from_filepath(file_path)
            if file_name == '媒体マスタ.csv':
                # オファーの金額文字列中のカンマを削除
                # カンマを先に削除しておかないと後続の処理でおかしくなるので最初に処理を実行する
                buf[13] = Util.replace_matched_string(r"([0-9]{1}),([0-9]{3})円", "\\1\\2円", buf[13])
                
            str_line = str(delimiter).join(buf)
            # 半角スペースの削除処理
            str_line = Util.remove_hankaku(str_line)
            # 先頭が下記条件に該当したら読み飛ばす
            if Util.search(r'^(\r\n|\n|\r|------|顧客ID|商品ID|媒体コード|伝票番号|年月|媒体ID)+', str_line) is not None:
                continue
            # 半角全角を統一（英数→半角に統一、カタカナ→全角に統一）
            str_line = Util.convert_to_halfwidth(str_line)
            
            #各ファイル毎のクレンジング処理
            buf_list = str_line.split(delimiter)
            if file_name == '顧客マスタ.csv':
                # 日付の文字列で/を-に変換する
                buf_list[5] = Util.change_date_delimiter(buf_list[5])
                buf_list[6] = Util.change_date_delimiter(buf_list[6])
            elif file_name == '発送実績データ.csv' or file_name == '売掛データ.csv':
                # 日付の文字列で年度が2桁になっているのを４桁に直す
                buf_list[2] = Util.modify_year(buf_list[2])
            elif file_name == '退会データ.csv':
                # 日付の文字列で年度が2桁になっているのを４桁に直す
                buf_list[1] = Util.modify_year(buf_list[1])
            elif file_name == '媒体マスタ.csv':
                # 日付の文字列で/を-に変換する
                buf_list[6] = Util.change_date_delimiter(buf_list[6])
                # timeの文字列を%H:%M:%Sに直す
                buf_list[7] = Util.modify_time(buf_list[7])
                buf_list[8] = Util.modify_time(buf_list[8])
            str_line = ",".join(buf_list)
            str_line = str_line + "\n"
            lines.append(bytes(str_line,'utf-8'))
        yield lines

# クレンジング処理したデータを一時的にGCSへ書き出す（アウトプットストリーム)
def output_data_to_gcs(storage_client, bucket_name,file_path, file_name, delimiter=','):
    
    try:
        file_obj = io.BytesIO()
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(file_name)
        
        #upload_from_fileを複数回呼び出すとエラーとなるため、リトライ処理の定義を行う
        modified_retry = DEFAULT_RETRY.with_deadline(_BACKOFF_DURATION)
        for buf in convert_file(file_path, delimiter):
            file_obj.writelines(buf)
            file_obj.seek(0)
            blob.upload_from_file(file_obj, retry=modified_retry)
        
        return "", 200
    except Exception as e:
            return "予期せぬエラーが発生しました: {}".format(e), 500

#　元ファイルをGCSから削除する
def remove_file_from_gcs(storage_client, bucket_name, blob_name, destination_blob_name):
    try:
        # 元ファイルを削除
        bucket = storage_client.bucket(bucket_name)
        destination_blob = bucket.blob(str(destination_blob_name))
        destination_blob.delete()
        # tempファイルを元ファイル名に修正
        source_blob = bucket.blob(blob_name)
        destination_generation_match_precondition = 0
        bucket.copy_blob(source_blob, bucket, destination_blob_name, if_generation_match=destination_generation_match_precondition)
        # tempファイルを削除
        source_blob.delete()
        
        return "", 200
    except Exception as e:
            return "予期せぬエラーが発生しました: {}".format(e), 500
        

def execute(cloud_event):
    #パラメータよりbucket_name, file_name, file-encodingを取得する
    request_args = cloud_event.args
    request_json = cloud_event.get_json(silent=True)
    file_encoding = 'utf-8'
    if request_args and 'bucket_name' in request_args and 'file_name' in request_args:
        bucket_name = request_args.get('bucket_name')
        file_name   = request_args.get('file_name')
        if 'file_encoding' in request_args:
            file_encoding = request_args.get('file_encoding')
    elif request_json and 'bucket_name' in request_json and 'file_name' in request_json:
        bucket_name = request_json.get('bucket_name')
        file_name = request_json.get('file_name')
        if 'file_encoding' in request_json:
            file_encoding = request_json.get('file_encoding')
    else:
        return "パラメータの指定に誤りがあります", 400
    
    storage_client = storage.Client()
    
    try:
        tmp_file_path, status_code = download_file(storage_client, bucket_name, file_name, file_encoding)
        if status_code != 200:
            return tmp_file_path, status_code
        tmp_file_name = "tmp_"+file_name
        output_message, status_code = output_data_to_gcs(storage_client, bucket_name, tmp_file_path, tmp_file_name)
        if status_code != 200:
            return output_message, status_code
        output_message, status_code = remove_file_from_gcs(storage_client, bucket_name, tmp_file_name, file_name)
        if status_code != 200:
            return output_message, status_code
    except Exception as e:
        return "予期せぬエラーが発生しました: {}".format(e), 500
    
    return "completed successfully",200
