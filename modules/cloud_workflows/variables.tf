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

variable "workflow_definition_path" {
  description = "Workflowの定義パス"
  type        = string
}