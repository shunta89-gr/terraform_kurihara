import yaml
from google.cloud import bigquery, storage
from google.cloud.exceptions import NotFound
from util.datelib import Datelib

##
#
# RawData
# 概要：
#   config.yamlに定義してある、指定されたbucket配下に置かれているデータソースを定義されたテーブルを作成し
#   BigQueryに取り込む処理を行う。
#
##
class RawData:

    ##
    #
    # __init__
    # コンストラクタ
    #
    ##
    def __init__(self) -> None:
        super().__init__()

    ##
    #
    # _getFileName
    # 機能概要：引数のバケットから指定されたファイルパスのファイル名を返す
    # 引数 :
    #  storage_client: cloud storageクライアント
    #  bucket_name : 検索するバケット名を指定する
    #  path :　検索するファイルパスを指定する
    #
    ##
    def _get_file_name(self, storage_client, bucket_name, path):
        blobs = storage_client.list_blobs(bucket_name, prefix=path, delimiter="/")

        for blob in blobs:
            return blob.name

        return None

    ##
    #
    # __already_exist_table_check
    # 機能概要: BigQueryにテーブルが存在するか確認する
    # 引数:
    #  bq_client: BigQueryクライアント
    #  table_id : table名を指定
    #  is_delete: trueを指定した場合、指定したtable_idが存在したら削除する
    # 戻り値:
    #  true : 指定したテーブルが存在する
    #  false: 指定したテーブルが存在しない
    #
    ##
    def __already_exist_table_check(self, bq_client, table_id, is_delete):
        try:
            table = bq_client.get_table(table_id)
            if is_delete:
                bq_client.delete_table(table)
            return True
        except NotFound:
            return False

    ##
    # __backup
    # 概要：
    #
    #
    ##
    def __backup(self, bq_client, project_id, dataset, table_name, target_date):

        try:
            table_id = "{project_id}.{dataset}.{table_name}".format(project_id=project_id, dataset=dataset, table_name=table_name)
            table = bq_client.get_table(table_id)
            buckup_table_id = "{project_id}.{backup_dataset}.{table_name}_{ymd}".format(project_id=project_id, backup_dataset=dataset, table_name=table_name, ymd=target_date)

            if not self.__already_exist_table_check(bq_client, buckup_table_id, False):
                job = bq_client.copy_table(table, buckup_table_id)
                job.result()

                bq_client.delete_table(table)
        except NotFound:
            #ToDo テーブルが見つからない場合エラーとはしないがどのような処理にするか考える
            return None
    ##
    #
    # __create_table
    # 機能概要: BigQueryにテーブルを作成する
    # 引数:
    #   bq_client  :BigQueryクライアント
    #   project_id :作成対象テーブルのプロジェクトIDを指定
    #   dataset    :作成対象テーブルのデータセットを指定
    #   table_name :作成対象テーブルのテーブル名を指定
    #   schema     :作成対象テーブルのスキーマをハッシュで指定
    ##
    def __create_table(self, bq_client, project_id, dataset, table_name, schemas):
        dataset_id = "{project_id}.{dataset}".format(project_id=project_id, dataset=dataset)
        table_id = "{project_id}.{dataset}.{table_name}".format(project_id=project_id, dataset=dataset, table_name=table_name)
        
        dataset = bigquery.Dataset(dataset_id)
        if not bq_client.get_dataset(dataset):
            dataset = bq_client.create_dataset(dataset, timeout=30)
        
        schema = []
        for buf in schemas:
            schema.append(bigquery.SchemaField(buf['name'], buf['type']))

        table = bigquery.Table(table_id, schema)
        self.__already_exist_table_check(bq_client, table_id, True)

        table = bq_client.create_table(table)

    ##
    # __import_csv
    # 概要：CSVファイルのデータをBigQueryにロードする
    # 引数：
    #   bq_client: BigQueryのクライアントインスタンス
    #   bucket_name: データソースが置かれているバケット名
    #   dataset: データをロードするBigQueryのデータセットを指定する
    #   table_name: データをロードするBigQueryのテーブル名を指定する
    #   file_path: データソースが置かれているファイルパス 
    #   field_delimiter: ファイルのデータの区切り文字を指定。デフォルトカンマ区切り
    ##
    def __import_csv(self, bq_client, bucket_name, dataset, table_name, file_path, field_delimiter=","):
        #BigQueryへデータロードするためのJob定義
        job_config = bigquery.LoadJobConfig()
        job_config.skip_leading_rows = 1
        job_config.field_delimiter = field_delimiter
        job_config.source_format = bigquery.SourceFormat.CSV

        dataset_ref = bq_client.dataset(dataset)
        table_ref = dataset_ref.table(table_name)

        uri = "gs://{bucket_name}/{file_path}".format(bucket_name=bucket_name, file_path=file_path)

        # ファイルをBigQueryへロードする
        load_job = bq_client.load_table_from_uri(
            uri,
            table_ref,
            job_config=job_config
        )
        load_job.result()

    ##
    #
    # __move_blob
    # 
    ##
    def __move_blob(self, storage_client, bucket_name, blob_name, buckup_bucket_name):
        source_bucket = storage_client.bucket(bucket_name)
        source_blog = source_bucket.blob(blob_name)
        destination_bucket = storage_client.bucket(buckup_bucket_name)
        destination_blob_name = "{}/{}".format(Datelib.today("%Y%m%d%H%M%S"), blob_name)
        destination_generation_match_precondition = 0
        
        blob_copy = source_bucket.copy_blob(
            source_blog, destination_bucket, destination_blob_name, 
            if_generation_match=destination_generation_match_precondition,
        )
        source_bucket.delete_blob(blob_name)
        
    ##
    #
    # exec
    # 機能概要: このクラスの実行メソッド。
    # 引数:
    #   target_date: 実行日を指定する。Nullの場合は、本日日付がデフォルトとなる.yyyyMMdd形式で指定する
    ##
    def exec(self, target_date=''):
        #config.yamlより設定内容を読み込む
        with open('./rawdata/config.yaml', 'r', encoding="utf-8") as yml:
            config = yaml.safe_load(yml)

        project_id = config['projectId']
        bucket_name = config['bucketName']
        backup_bucket_name = config['backupBucketName']

        bq_client = bigquery.Client(project=project_id)
        storage_client = storage.Client()
        
        cal_target_date=""
        if not target_date:
            cal_target_date = Datelib.today("%Y%m%d")
        else:
            cal_target_date = target_date

        table_name_ymd=""

        #configのtargetsに設定されている内容を読み込む
        for target in config['targets']:

            file_search_path = target['fileSearchPath'] #データソースが置かれているファイルパス
            field_delimiter = target['fieldDelimiter']
            dataset = target['dataset']
            table_name = target['tableName']
            is_master = target['isMaster']
            schema = target['schema']

            # Cloud Storate上に指定したデータソースが存在するか確認する
            file_name = self._get_file_name(storage_client, bucket_name, file_search_path)

            if not file_name is None:
                if is_master:
                    self.__backup(bq_client, project_id, dataset, table_name, cal_target_date)
                    self.__create_table(bq_client, project_id, dataset, table_name, schema)
                    self.__import_csv(bq_client, bucket_name, dataset, table_name, file_name, field_delimiter)
                else:
                    table_name_ymd = "{table_name}_{ymd}".format(table_name=table_name, ymd=cal_target_date)
                    self.__create_table(bq_client, project_id, dataset, table_name_ymd, schema)
                    self.__import_csv(bq_client, bucket_name, dataset, table_name_ymd, file_name, field_delimiter)
                    
                self.__move_blob(storage_client, bucket_name, file_name, backup_bucket_name)
