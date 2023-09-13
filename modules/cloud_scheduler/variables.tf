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
