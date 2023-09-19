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
    #  format :　日付のフォーマットを指定する(ex. %Y%m)
    #
    ##
    def _get_file_name(self, storage_client, bucket_name, path, date_format):
        search_path = path.format(Datelib.today(date_format))

        blobs = storage_client.list_blobs(bucket_name, prefix=search_path, delimiter="/")

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
    #
    #
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
        table_id = "{project_id}.{dataset}.{table_name}".format(project_id=project_id, dataset=dataset, table_name=table_name)
        schema = []
        for buf in schemas:
            schema.append(bigquery.SchemaField(buf['name'], buf['type']))

        table = bigquery.Table(table_id, schema)
        self.__already_exist_table_check(bq_client, table_id, True)

        table = bq_client.create_table(table)

    ##
    #
    #
    #
    #
    ##
    def __import_csv(self, bq_client, bucket_name, dataset, table_name, file_name, field_delimiter):
        #BigQueryへデータロードするためのJob定義
        job_config = bigquery.LoadJobConfig()
        job_config.skip_leading_rows = 1
        job_config.field_delimiter = field_delimiter
        job_config.source_format = bigquery.SourceFormat.CSV

        dataset_ref = bq_client.dataset(dataset)
        table_ref = dataset_ref.table(table_name)

        uri = "gs://{bucket_name}/{file_name}".format(bucket_name=bucket_name, file_name=file_name)

        # ファイルをBigQueryへロードする
        load_job = bq_client.load_table_from_url(
            uri,
            table_ref,
            job_config=job_config
        )
        load_job.result()

    ##
    #
    # exec
    # 機能概要: このクラスの実行メソッド。
    # 引数:
    #   target_date: 実行日を指定する。Nullの場合は、本日日付がデフォルトとなる
    ##
    def exec(self, target_date):

        #config.yamlより設定内容を読み込む
        with open('./rawdata/config.yaml', 'r', encoding="utf-8") as yml:
            config = yaml.safe_load(yml)

        project_id = config['projectId']
        bucket_name = config['bucketName']

        bq_client = bigquery.Client(project=project_id)
        storage_client = storage.Client()

        #configのtargetsに設定されている内容を読み込む
        for target in config['targets']:

            file_search_path = target['fileSearchPath'] #データソースが置かれているファイルパス
            date_format = target['format']
            field_delimiter = target['fieldDelimiter']
            dataset = target['dataset']
            table_name = target['tableName']
            is_master = target['isMaster']
            schema = target['schema']

            file_name = self._get_file_name(storage_client, bucket_name, file_search_path, date_format)

            if not file_name is None:
                if is_master:
                    self.__backup(bq_client, project_id, dataset, table_name, target_date)
                    self.__create_table(bq_client, project_id, dataset, table_name, schema)
                    self.__import_csv(bq_client, bucket_name, dataset, table_name, file_name, field_delimiter)
                else:
                    self.__create_table(bq_client, project_id, dataset, table_name, schema)
                    self.__import_csv(bq_client, bucket_name, dataset, table_name, file_name, field_delimiter)
        