resource "google_project_iam_member" "dataform_sa_binding" {
    project = var.project_id
    count   = length(var.dataform_sa_roles)
    role    = element(var.dataform_sa_roles, count.index)
    member  = "serviceAccount:${google_service_account.dataform_sa.email}"
}