resource "google_iam_workload_identity_pool" "pool" {
  provider = google-beta
  project  = var.project_id

  workload_identity_pool_id = "my-pool"
  display_name              = "my-pool"
  description               = "Github Actionsで使用するためのPool"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  provider = google-beta
  project  = var.project_id

  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "my-pool-provider"
  display_name                       = "my-pool-provider"
  description                        = "Github Actionsで使用するためのProvider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# data "google_service_account" "terraform_sa" {
#     account_id = "terraform@gpj-bi-kenkoukazoku.iam.gserviceaccount.com"
# }
# resource "google_service_account_iam_member" "sa_binding" {
#   service_account_id = data.google_service_account.terraform_sa.id
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/my-org/my-repo"
# }

