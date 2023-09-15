resource "google_project_iam_binding" "workflow_sa_binding" {
  project = var.project_id
  count   = length(var.workflow_sa_roles)
  role    = var.workflow_sa_roles[count.index]

  members = [
    "serviceAccount:${google_service_account.workflow_sa.email}",
  ]
}
