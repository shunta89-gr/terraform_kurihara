module "data-sorce-bucket" {
  source        = "../../modules/cloud_storage"
  # TODO: storage_nameを自分の環境に合わせて変更する
  storage_name  = "tosashimizu-rawdata"
  location      = "asia-northeast1"
  force_destroy = false
}

module "data-sorce-backup-bucket" {
  source        = "../../modules/cloud_storage"
  # TODO: storage_nameを自分の環境に合わせて変更する
  storage_name  = "tosashimizu-rawdata-backup"
  location      = "asia-northeast1"
  force_destroy = false
}

module "functions-bucket" {
  source        = "../../modules/cloud_storage"
  # TODO: storage_nameを自分の環境に合わせて変更する
  storage_name  = "tosashimizu-functions"
  location      = "asia-northeast1"
  force_destroy = false
}