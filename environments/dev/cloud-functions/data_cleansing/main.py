from google.cloud import bigquery, storage
from util import Util

# gcsからファイルをダウンロード
def download_file(storage_client, bucket_name, file_name, encoding):
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob = blob.download_as_text(encoding=encoding)
    buf = file_name.split("/")
    temp_file = "/tmp/{}".format(buf[-1])

    with open(temp_file, mode='wb') as fs:
        fs.write(blob.encode('utf-8'))
        fs.flush()
    
    return temp_file

# ファイルの変換処理
def convert_file(file_path, delimiter=','):
    buf_lines = []
    with open(file_path, mode="r") as f:
        for line in f:
            # 半角スペースの削除処理
            buf = Util.remove_hankaku(line)
            # 先頭が下記条件に該当したら読み飛ばす
            if Util.search(r'^(\r\n|\n|\r|------|顧客ID|商品ID|媒体コード|伝票番号|年月|媒体ID)+', buf) is not None:
                continue
            # 半角全角を統一（英数→半角に統一、カタカナ→全角に統一）
            buf = Util.convert_to_halfwidth(buf)
            file_name = Util.get_filename_from_filepath(file_path)
            #各ファイル毎のクレンジング処理
            buf_list = buf.split(delimiter)
            if file_name == '顧客マスタ.csv':
                # 日付の文字列で/を-に変換する
                buf_list[5] = Util.change_date_delimiter(buf_list[5])
                buf_list[6] = Util.change_date_delimiter(buf_list[6])
            elif file_name == '発送実績データ.csv' or file_name == '売掛データ':
                # 日付の文字列で年度が2桁になっているのを４桁に直す
                buf_list[2] = Util.modify_year(buf_list[2])
            elif file_name == '退会データ.csv':
                # 日付の文字列で年度が2桁になっているのを４桁に直す
                buf_list[1] = Util.modify_year(buf_list[1])
            elif file_name == '媒体マスタ.csv':
                # timeの文字列を%H:%M:%Sに直す
                buf_list[7] = Util.modify_time(buf_list[7])
                buf_list[8] = Util.modify_time(buf_list[8])
                # オファーの金額文字列中のカンマを削除
                buf_list[13] = Util.replace_matched_string(r"([0-9]{1}),([0-9]{3})円", "\\1\\2円", buf_list[13])
            
            buf = ",".join(buf_lines)
            buf_lines.append(buf)

    # 前処理したデータをファイルに書き出す    
    with open(file_path, 'w') as f:
        f.writelines(buf_lines)
    return

#　元ファイルをGCSから削除する
def remove_file_from_gcs(storage_client, bucket_name, blob_name):
        bucket = storage_client.bucket(bucket_name)
        bucket.delete_blob(blob_name)

# 変換したファイルをgcsに戻す
def upload_file_to_gcs(storage_client, bucket_name, file_name, local_file_path):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob.upload_from_filename(local_file_path)
    
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
    
    tmp_file_path = download_file(storage_client, bucket_name, file_name, file_encoding)
    convert_file(tmp_file_path)
    remove_file_from_gcs(storage_client, bucket_name, file_name)
    upload_file_to_gcs(storage_client, bucket_name, file_name, tmp_file_path)
    
    return "completed successfully",200