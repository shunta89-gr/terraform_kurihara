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
    bucket = "tosashimizu-tfstate"
    # credentials = "../../json-key/gpj-anarisys-tosashimizu-2c51e3758046.json"
  }
}

# プロバイダ設定
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
  # credentials = "../../json-key/gpj-an/arisys-tosashimizu-2c51e3758046.json"
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  # credentials = "../../json-key/gpj-anarisys-tosashimizu-2c51e3758046.json"
}

variable "project_id" {
  description = "プロジェクトID"
  default     = "gpj-anarisys-tosashimizu"
}

variable "project_name" {
  description = "プロジェクト名"
  default     = "tosashimizu-anarisys"
}

variable "environment_name" {
  description = "環境名"
  default     = "prod"
}

variable "region" {
  description = "デフォルトGCPリージョン"
  default     = "asia-northeast1"
}

variable "gh_private_key" {
  description = "GitHubの秘密鍵"
  default     = ""
}