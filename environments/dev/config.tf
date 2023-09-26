terraform {
  required_version = "~> 1.5.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.82.0"
    }
  }
  backend "gcs" {
    # TODO:本番作成時には、backend用backetを手動作成、指定が必要
    bucket      = "kenkoukazoku-tfstate-dev"
    credentials = "../../json-key/dev-dbd-64657934cd92.json"
  }
}

# プロバイダ設定
provider "google" {
  credentials = file("../../json-key/dev-dbd-64657934cd92.json")
  project = var.project_id
  region = "asia-northeast1" 
  zone = "asia-northeast1-a"
}

provider "google-beta" {
  credentials = file("../../json-key/dev-dbd-64657934cd92.json")
  project = "dev-dbd"
  region = "asia-northeast1" 
}

variable "project_id" {
  description = "プロジェクトID"
  default     = "dev-dbd"
}

variable "project_name" {
  description = "プロジェクト名"
  default     = "kenkokazoku"
}

variable "environment_name" {
  description = "環境名"
  default     = "dev"
}

variable "region" {
  description = "デフォルトGCPリージョン"
  default     = "asia-northeast1"
}
