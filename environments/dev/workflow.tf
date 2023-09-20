module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "kenkokazoku-workflow"
  workflow_sa_id           = "kenkokazoku-workflow-sa"
  workflow_sa_display_name = "Service Account for Workflow"
  workflow_sa_roles = [
    // TODO:dataform、functions実行のための最小必要権限の追加
    "roles/logging.logWriter"
  ]
}
