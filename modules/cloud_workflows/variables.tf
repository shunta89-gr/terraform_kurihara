variable "project_id" {
  description = "プロジェクトID(受け取り用)"
  type        = string
}

variable "workflow_name" {
  description = "Workflowの名前"
  type        = string
}

variable "workflow_definition" {
  description = "ワークフローの定義内容"
  type        = string
}

variable "workflow_service_account" {
  description = "ワークフローのサービスアカウント"
  type        = string
}

variable "alert_channel_ids" {
  description = "Workflowsのアラートの通知チャンネルID"
  type        = list(string)
}
