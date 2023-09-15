variable "project_id" {
  description = "プロジェクトID(受け取り用)"
  type        = string
}

variable "workflow_name" {
  description = "Workflowの名前"
  type        = string
  default     = "kenkokazoku-workflow"
}

variable "workflow_sa_id" {
  description = "Workflow用サービスアカウントID"
  default     = "kenkokazoku-workflow-executer"
}

variable "workflow_sa_display_name" {
  description = "Workflow用サービスアカウントのディスプレイネーム"
  default     = "Service Account for Workflow"
}

variable "workflow_sa_roles" {
  description = "Workflow用サービスアカウントIDに割り当てるロール"
  type        = list(string)
  default = [
    // TODO:dataform、functions実行のための最小必要権限の追加
    "roles/workflows.executions.create",
    "roles/logging.logWriter"
  ]
}
