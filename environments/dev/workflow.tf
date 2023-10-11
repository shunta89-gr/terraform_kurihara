data "template_file" "workflow_template" {
  template = file("./cloud-workflows/workflow.yaml")

  vars = {
    PROJECT_ID                  = var.project_id
    REPOSITORY_LOCATION         = var.region
    REPOSITORY_ID               = module.dataform.dataform_repository_id
    CLOUD_FUNCTION_ENDPOINT_URL = module.import_csv_to_bq.function_uri
    GIT_COMMITISH               = "main"
  }
}

module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "kenkokazoku-workflow"
  workflow_sa_id           = "kenkokazoku-workflow-sa"
  workflow_sa_display_name = "Service Account for Workflow"
  workflow_sa_roles = [
    "roles/run.invoker",
    "roles/dataform.editor",
    "roles/logging.logWriter"
  ]
  workflow_definition = data.template_file.workflow_template.rendered
}
