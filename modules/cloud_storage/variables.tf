variable "storage_name" {
  description = "Cloud Storageの名前"
  type        = string
  default     = ""
}

variable "location" {
  description = "Cloud Storageのロケーション"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Cloud Storageの強制削除フラグ"
  type        = bool
  default     = false
}