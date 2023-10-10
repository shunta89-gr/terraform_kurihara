module "cloud_functions" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/src"
    output_path          = "./cloud-functions/src.zip"
    bucket_name          = module.functions-bucket.bucket_name
    bucket_region        = var.region
    function_region      = var.region
    function_name        = "kenkoukazoku-function"
    function_description = "rowデータの取り込み処理"
    function_runtime     = "python311"
    entry_point          = "import_csv"
    function_memory      = "512M"
    timeout_seconds      = 3600

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
    function_memory      = "16G"
    timeout_seconds      = 3600

}