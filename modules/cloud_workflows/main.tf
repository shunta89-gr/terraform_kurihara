resource "google_workflows_workflow" "main" {
  name            = var.workflow_name
  service_account = google_service_account.workflow_sa.email
  source_contents = join("", [
    templatefile(var.workflow_definition_path, {})
  ])
}
