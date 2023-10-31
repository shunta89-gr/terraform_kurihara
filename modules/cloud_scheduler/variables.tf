variable "project_id" {
  description = "プロジェクトID(受け取り用)"
  type        = string
}

variable "region" {
  description = "リージョン(受け取り用)"
  type        = string
}

variable "job_name" {
  description = "Cloud Scheduler Jobの名前"
  type        = string
}

variable "job_schedule" {
  description = "Cloud Scheduler Jobのスケジュール"
  type        = string
}

variable "scheduler_sa_id" {
  description = "Sheduler用サービスアカウントID"
  type        = string
}

variable "scheduler_sa_display_name" {
  description = "Scheduler用サービスアカウントのディスプレイネーム"
  type        = string
}

variable "scheduler_sa_roles" {
  description = "Scheduler用サービスアカウントIDに割り当てるロール"
  type        = list(string)
}

variable "target_workflow_name" {
  description = "Schedulerで実行するWorkflowの名前"
  type        = string
}

variable "time_zone" {
  description = "Cloud Scheduler Jobのタイムゾーン"
  type = string
}

variable "alert_channel_ids" {
  description = "Schedulerのアラートの通知チャンネルID"
  type        = list(string)
}
