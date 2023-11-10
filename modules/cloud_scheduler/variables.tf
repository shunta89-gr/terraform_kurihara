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

variable "target_workflow_name" {
  description = "Schedulerで実行するWorkflowの名前"
  type        = string
}

variable "time_zone" {
  description = "Cloud Scheduler Jobのタイムゾーン"
  type = string
}

variable "sa_email" {
  type = string
}
