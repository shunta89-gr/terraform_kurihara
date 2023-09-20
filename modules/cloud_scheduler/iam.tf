resource "google_project_iam_member" "scheduler_sa_binding" {
  project = var.project_id
  count   = "${length(var.scheduler_sa_roles)}"
  role    = "${element(var.scheduler_sa_roles, count.index)}"
  member = "serviceAccount:${google_service_account.scheduler_sa.email}"
}