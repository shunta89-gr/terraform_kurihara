module "data-sorce-bucket" {
    source = "../../modules/cloud_storage"
    storage_name = "kenkoukazoku-rawdata-dev"
    location = "asia-northeast1"
    force_destroy = true
}

module "data-sorce-backup-bucket" {
    source = "../../modules/cloud_storage"
    storage_name = "kenkoukazoku-rawdata-backup-dev"
    location = "asia-northeast1"
    force_destroy = true
}

module "functions-bucket" {
    source = "../../modules/cloud_storage"
    storage_name = "kenkoukazoku-function-dev"
    location = "asia-northeast1"
    force_destroy = true
}