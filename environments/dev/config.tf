terraform {
    required_version = "~> 1.5.4"
    required_providers { 
        google = {
            source = "hashicorp/google"
            version = "~>4.82.0" 
        }
    }
    backend "gcs" {
        bucket = "kenkoukazoku-tfstate-dev"
        credentials = "../../json-key/dev-dbd-64657934cd92.json"
    }
}

# プロバイダ設定
provider "google" {
  credentials = file("../../json-key/dev-dbd-64657934cd92.json")
  project = "dev-dbd"
  region = "asia-northeast1" 
  zone = "asia-northeast1-a"
}