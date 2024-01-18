# functionのスクリプト用コンフィグを共通ディレクトリにコピーする
resource "local_file" "config_yaml" {
  content = templatefile("../common/cloud-functions/import-csv-to-bq-config.yaml.tpl", {
    project_id         = var.project_id
    bucket_name        = module.data-sorce-bucket.bucket_name
    backup_bucket_name = module.data-sorce-backup-bucket.bucket_name
  })
  filename = "../common/cloud-functions/import-csv-to-bq/rawdata/config.yaml"
}

module "import_csv_to_bq" {
  source = "../../modules/cloud_functions"

  source_dir           = "../common/cloud-functions/import-csv-to-bq"
  output_path          = "../common/cloud-functions/import-csv-to-bq.zip"
  bucket_name          = module.functions-bucket.bucket_name
  bucket_region        = var.region
  function_region      = var.region
  function_name        = "import-csv-to-bq"
  function_description = "rowデータの取り込み処理"
  function_runtime     = "python311"
  entry_point          = "execute"
  function_memory      = "512M"
  timeout_seconds      = 3600
  max_instance_count   = 8 #クレンジングするファイル数と同じにする

  # コンフィグファイルのコピー後に実行
  depends_on = [
    local_file.config_yaml
  ]
}

module "import_csv_to_bq_init" {
  source = "../../modules/cloud_functions"

  source_dir           = "../common/cloud-functions/import-csv-to-bq"
  output_path          = "../common/cloud-functions/import-csv-to-bq.zip"
  bucket_name          = module.functions-bucket.bucket_name
  bucket_region        = var.region
  function_region      = var.region
  function_name        = "import-csv-to-bq-init"
  function_description = "rowデータの取り込み処理"
  function_runtime     = "python311"
  entry_point          = "init"
  function_memory      = "512M"
  timeout_seconds      = 3600
  max_instance_count   = 1

  # コンフィグファイルのコピー後に実行
  depends_on = [
    local_file.config_yaml
  ]
}

module "data_cleansing" {
  source = "../../modules/cloud_functions"

  source_dir           = "../common/cloud-functions/data_cleansing"
  output_path          = "../common/cloud-functions/data_cleansing.zip"
  bucket_name          = module.functions-bucket.bucket_name
  bucket_region        = var.region
  function_region      = var.region
  function_name        = "data-cleansing"
  function_description = "データクレンジング処理"
  function_runtime     = "python311"
  entry_point          = "execute"
  function_memory      = "4G"
  timeout_seconds      = 3600
  max_instance_count   = 8 #クレンジングするファイル数と同じにする
}

