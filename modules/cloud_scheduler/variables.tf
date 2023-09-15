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
  default     = "kenkokazoku-job"
}

variable "job_schedule" {
  description = "Cloud Scheduler Jobのスケジュール"
  type        = string
  default     = "0 0 1 * *"  #TODO:タイミングは決まり次第変更
}

variable "scheduler_sa_id" {
  description = "Sheduler用サービスアカウントID"
  default     = "kenkokazoku-job-executer"
}

variable "scheduler_sa_display_name" {
  description = "Scheduler用サービスアカウントのディスプレイネーム"
  default     = "Service Account for Scheduler"
}

variable "scheduler_sa_roles" {
  description = "Scheduler用サービスアカウントIDに割り当てるロール"
  type        = list(string)
  default     = [
    "roles/workflows.executor"
  ] 
}

variable "target_workflow_name" {
  description = "Schedulerで実行するWorkflowの名前"
  type        = string
  default     = "kenkokazoku-workflow"
}