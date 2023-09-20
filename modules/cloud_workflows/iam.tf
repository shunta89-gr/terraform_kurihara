resource "google_project_iam_member" "workflow_sa_binding" {
  project = var.project_id
  count   = length(var.workflow_sa_roles)
  role    = element(var.workflow_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.workflow_sa.email}"
}
