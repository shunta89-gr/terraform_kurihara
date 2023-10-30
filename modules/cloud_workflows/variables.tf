variable "project_id" {
  description = "プロジェクトID(受け取り用)"
  type        = string
}

variable "workflow_name" {
  description = "Workflowの名前"
  type        = string
}

variable "workflow_sa_id" {
  description = "Workflow用サービスアカウントID"
  type        = string
}

variable "workflow_sa_display_name" {
  description = "Workflow用サービスアカウントのディスプレイネーム"
  type        = string
}

variable "workflow_sa_roles" {
  description = "Workflow用サービスアカウントIDに割り当てるロール"
  type        = list(string)
}

variable "workflow_definition" {
  description = "ワークフローの定義内容"
  type        = string
}

variable "alert_channel_ids" {
  description = "Workflowsのアラートの通知チャンネルID"
  type        = list(string)
}
