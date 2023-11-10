resource "google_workflows_workflow" "main" {
  name            = var.workflow_name
  service_account = var.workflow_service_account
  source_contents = var.workflow_definition
}
