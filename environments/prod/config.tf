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
    bucket = "tf_kurihara_buchet"
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

# TODO: プロジェクトIDを自分の環境に合わせて変更する
variable "project_id" {
  description = "プロジェクトID"
  default     = "gpj-gd3-dev-kurihara"
}

# TODO: プロジェクト番号を自分の環境に合わせて変更する
variable "project_number" {
  description = "プロジェクト番号"
  default     = "1021452053185"
}


# TODO: プロジェクト名を自分の環境に合わせて変更する
variable "project_name" {
  description = "プロジェクト名"
  default     = "kurihara_project"
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