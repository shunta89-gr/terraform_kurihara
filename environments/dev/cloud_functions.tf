module "cloud_functions" {
    source = "../../modules/cloud_functions"
    
    source_dir           = "./cloud-functions/src"
    output_path          = "./cloud-functions/src.zip"
    bucket_name          = "kenkoukazoku-function-dev"
    bucket_region        = "asia-northeast1"
    function_region      = "asia-northeast1"
    function_name        = "kenkoukazoku-function"
    function_description = "rowデータの取り込み処理"
    function_runtime     = "python311"
    entry_point          = "import_csv"
    function_memory      = "512M"
    timeout_seconds      = 3600

}