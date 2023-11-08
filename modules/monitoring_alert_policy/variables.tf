variable "job_name" {
  description = "アラートの通知チャンネルに設定するジョブ名"
  type        = string
}

variable "alert_channel_ids" {
  description = "アラートの通知チャンネルID"
  type        = list(string)
}

variable "filter" {
    description = "アラート条件"
    type        = string
}