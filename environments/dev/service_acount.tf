module "worlflow_sa" {
  source                   = "../../modules/service_acount"
  project_id               = var.project_id
  sa_id           = "kenkokazoku-workflow-sa"
  sa_display_name = "Service Account for Workflow"
  sa_roles = [
    "roles/run.invoker",
    "roles/dataform.editor",
    "roles/logging.logWriter",
    "roles/workflows.invoker"
  ]
}