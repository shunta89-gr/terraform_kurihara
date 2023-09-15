resource "google_service_account" "workflow_sa" {
  account_id   = var.workflow_sa_id
  display_name = var.workflow_sa_display_name
}