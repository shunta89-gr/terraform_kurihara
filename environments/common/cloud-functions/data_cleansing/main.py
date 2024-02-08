from google.cloud import storage
from google.cloud.storage.retry import DEFAULT_RETRY
from google.api_core import exceptions as ex
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
    except ex.NotFound:
        return "ファイルが存在しませんでした[{}]".format(file_name), 204        
    except Exception as e:
        return "ファイルのダウンロード中にエラーが発生しました: {}".format(e), 500

# ファイルの変換処理
def convert_file(file_path, delimiter=','):
    chunks = pd.read_csv(file_path, chunksize=chunk_size, header=None, skiprows=1, na_filter=False, dtype=str)
    for chunk in chunks:
        lines = []
        for buf in chunk.to_numpy():
            file_name = Util.get_filename_from_filepath(file_path)
                        #各ファイル毎のクレンジング処理
            if file_name == 'めじか個人台帳.csv':
                # 年度の作成
                # 取り込んだ文字列から先頭４文字を抽出
                if buf[3].isdecimal():
                    nendo = Util.excel_date(buf[3],'%Y-%m-%d')
                    buf[3] = Util.create_year(nendo)
                else:
                    buf[3] = Util.create_year(buf[3])
                # 日付の文字列で/を-に変換する
                if buf[10].isdecimal():
                    buf[10] = Util.excel_date(buf[10],'%Y-%m-%d')
                else:
                    buf[10] = Util.change_date_delimiter(buf[10])
                if buf[30].isdecimal():
                    buf[30] = Util.excel_date(buf[30],'%Y-%m-%d')
                else:
                    buf[30] = Util.change_date_delimiter(buf[30])
                if buf[31].isdecimal():
                    buf[31] = Util.excel_date(buf[31],'%Y-%m-%d')
                else:
                    buf[31] = Util.change_date_delimiter(buf[31])
                # 郵便番号の‐を削除
                buf[13] = buf[13].replace("-", "")
                # 改行を””で囲んで読み込まないようにする
                buf[27] = "\"" + buf[27] + "\""
                buf[29] = "\"" + buf[29] + "\""
                buf[33] = "\"" + buf[33] + "\""
            elif file_name == '観光台帳.csv':
                # 8桁に満たない地域通貨会員コードを0で埋めて8桁にする
                buf[2] = buf[2].zfill(8)
                # 日付の文字列で/を-に変換する
                buf[14] = Util.change_date_delimiter(buf[14])
                buf[19] = Util.change_date_delimiter(buf[19])
                # datetime型で取り込めるように秒数表示できていない箇所に":00"を追加
                buf[19] = Util.join_seconds(buf[19])
            elif file_name == '利用状況一覧.csv' :
                # 日付の文字列で/を-に変換する
                buf[1] = Util.change_date_delimiter(buf[1])
                buf[1] = Util.modify_datetime(buf[1])
                # 金額の,を削除
                buf[3] = buf[3].replace(",", "")
                # マネー・ポイント名を””で囲む
                buf[8] = "\"" + buf[8] + "\""
                # 店舗名のクレンジング処理
                # 半角・全角スペースを削除
                buf[12] = buf[12].replace(" ", "")
                buf[12] = buf[12].replace("　", "")
                #半角全角を統一（英数→半角に統一、カタカナ→全角に統一)
                buf[12] = Util.convert_to_halfwidth(buf[12])
            elif file_name == '発行一覧.csv':
                # 金額の,を削除
                buf[11] = buf[11].replace(",", "")
                # 日付の文字列で/を-に変換する
                buf[12] = Util.change_date_delimiter(buf[12])
                buf[13] = Util.change_date_delimiter(buf[13])
                # 店舗名のクレンジング処理
                # 半角・全角スペースを削除
                buf[9] = buf[9].replace(" ", "")
                buf[9] = buf[9].replace("　", "")
                #半角全角を統一（英数→半角に統一、カタカナ→全角に統一)
                buf[9] = Util.convert_to_halfwidth(buf[9])
                # 操作ユーザのクレンジング処理
                # 半角・全角スペースを削除
                buf[14] = buf[14].replace(" ", "")
                buf[14] = buf[14].replace("　", "")
                #半角全角を統一（英数→半角に統一、カタカナ→全角に統一)
                buf[14] = Util.convert_to_halfwidth(buf[14])
                #備考を””で囲む
                buf[15] = "\"" + buf[15] + "\""
            elif file_name == '店舗一覧.csv':
                # 店舗名のクレンジング処理
                # 半角・全角スペースを削除
                buf[0] = buf[0].replace(" ", "")
                buf[0] = buf[0].replace("　", "")
                #半角全角を統一（英数→半角に統一、カタカナ→全角に統一)
                buf[0] = Util.convert_to_halfwidth(buf[0])
                buf[1] = buf[1].replace(" ", "")
                buf[1] = buf[1].replace("　", "")
                #半角全角を統一（英数→半角に統一、カタカナ→全角に統一)
                buf[1] = Util.convert_to_halfwidth(buf[1])
                
            str_line = ",".join(buf)
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
            return "予期せぬエラーが発生しました({}): {}".format(file_name,e), 500

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
            return "予期せぬエラーが発生しました({}): {}".format(blob_name,e), 500
        

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
        
        return "completed successfully", 200
    except Exception as e:
        return "予期せぬエラーが発生しました({}): {}".format(file_name,e), 500
