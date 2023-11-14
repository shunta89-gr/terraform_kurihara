module "data-sorce-bucket" {
  source        = "../../modules/cloud_storage"
  storage_name  = "kenkoukazoku-rawdata"
  location      = "asia-northeast1"
  force_destroy = false
}

module "data-sorce-backup-bucket" {
  source        = "../../modules/cloud_storage"
  storage_name  = "kenkoukazoku-rawdata-backup"
  location      = "asia-northeast1"
  force_destroy = false
}

module "functions-bucket" {
  source        = "../../modules/cloud_storage"
  storage_name  = "kenkoukazoku-functions"
  location      = "asia-northeast1"
  force_destroy = false
}