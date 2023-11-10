resource "google_service_account" "main" {
  account_id   = var.sa_id
  display_name = var.sa_display_name
}

resource "google_project_iam_member" "sa_binding" {
  project = var.project_id
  count   = length(var.sa_roles)
  role    = element(var.sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.main.email}"
}
