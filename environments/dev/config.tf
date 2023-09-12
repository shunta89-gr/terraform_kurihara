terraform {
    required_version = "~> 1.5.4"
    required_providers { 
        google = {
            source = "hashicorp/google"
            version = "~>4.76.0" 
        }
    }
}

# プロバイダ設定
provider "google" {
  credentials = file("../../json-key/dev-dbd-64657934cd92.json")
  project = "dev-dbd"
  region = "asia-northeast1" 
  zone = "asia-northeast1-a"
}

# ----------------
# モジュール設定
# ----------------

# GCPサービス有効化
module "google_project_service" {
    source = "../../modules/gcp_enable_services"
}

# クラウドスケジューラー
module "cloud_scheduler" {
  source = "../../modules/cloud_scheduler"
}