module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "kenkokazoku-workflow"
  workflow_sa_id           = "kenkokazoku-workflow-sa"
  workflow_sa_display_name = "Service Account for Workflow"
  workflow_sa_roles = [
    "roles/cloudfunctions.invoker",
    "roles/dataform.editor",
    "roles/logging.logWriter"
  ]
  workflow_definition_path = "./cloud-workflows/main.yaml"
}
