module "data-sorce-bucket" {
    source = "../../modules/cloud_storage"
    storage_name = "kenkoukazoku-rawdata"
    location = "asia-northeast1"
}

module "data-sorce-backup-bucket" {
    source = "../../modules/cloud_storage"
    storage_name = "kenkoukazoku-rawdata-backup"
    location = "asia-northeast1"
}