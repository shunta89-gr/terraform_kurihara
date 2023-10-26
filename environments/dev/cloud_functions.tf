module "import_csv_to_bq" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/import-csv-to-bq"
    output_path          = "./cloud-functions/import-csv-to-bq.zip"
    bucket_name          = module.functions-bucket.bucket_name
    bucket_region        = var.region
    function_region      = var.region
    function_name        = "import-csv-to-bq"
    function_description = "rowデータの取り込み処理"
    function_runtime     = "python311"
    entry_point          = "execute"
    function_memory      = "512M"
    timeout_seconds      = 3600
    max_instance_count   = 11 #クレンジングするファイル数と同じにする
}

module "import_csv_to_bq_init" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/import-csv-to-bq"
    output_path          = "./cloud-functions/import-csv-to-bq.zip"
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
}

module "data_cleansing" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/data_cleansing"
    output_path          = "./cloud-functions/data_cleansing.zip"
    bucket_name          = module.functions-bucket.bucket_name
    bucket_region        = var.region
    function_region      = var.region
    function_name        = "data-cleansing"
    function_description = "データクレンジング処理"
    function_runtime     = "python311"
    entry_point          = "execute"
    function_memory      = "4G"
    timeout_seconds      = 3600
    max_instance_count   = 11 #クレンジングするファイル数と同じにする
}

module "unzip" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/unzip"
    output_path          = "./cloud-functions/unzip.zip"
    bucket_name          = module.functions-bucket.bucket_name
    bucket_region        = var.region
    function_region      = var.region
    function_name        = "unzip"
    function_description = "zip解凍処理"
    function_runtime     = "python311"
    entry_point          = "execute"
    function_memory      = "2G"
    timeout_seconds      = 3600

}