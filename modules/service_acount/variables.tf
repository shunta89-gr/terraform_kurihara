variable "project_id" {
  description = "プロジェクトID(受け取り用)"
  type        = string
}

variable "sa_id" {
  description = "サービスアカウントID"
  type        = string
}

variable "sa_display_name" {
  description = "サービスアカウントのディスプレイネーム"
  type        = string
}

variable "sa_roles" {
  description = "サービスアカウントIDに割り当てるロール"
  type        = list(string)
}
