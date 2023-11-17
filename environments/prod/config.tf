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
    bucket = "kenkoukazoku-tfstate"
    # credentials = "../../json-key/gpj-bi-kenkoukazoku-946fbf7d0b2c.json"
  }
}

# プロバイダ設定
provider "google" {
  # credentials = file("../../json-key/gpj-bi-kenkoukazoku-946fbf7d0b2c.json")
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
}

provider "google-beta" {
  # credentials = file("../../json-key/gpj-bi-kenkoukazoku-946fbf7d0b2c.json")
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  description = "プロジェクトID"
  default     = "gpj-bi-kenkoukazoku"
}

variable "project_name" {
  description = "プロジェクト名"
  default     = "kenkokazoku"
}

variable "environment_name" {
  description = "環境名"
  default     = "prod"
}

variable "region" {
  description = "デフォルトGCPリージョン"
  default     = "asia-northeast1"
}
