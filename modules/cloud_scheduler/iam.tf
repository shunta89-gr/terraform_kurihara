resource "google_project_iam_binding" "scheduler_sa_binding" {
  project = var.project_id
  count   = length(var.scheduler_sa_roles)
  role    = var.scheduler_sa_roles[count.index]

  members = [
    "serviceAccount:${google_service_account.scheduler_sa.email}",
  ]
}