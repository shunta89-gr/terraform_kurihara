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

resource "google_service_account" "github_actions_sa" {
    project = var.project_id
    account_id = "github-actions"
    display_name = "github-actions"
    description = "Github Actionsで使用するためのService Account"
}

resource "google_service_account_iam_member" "github_actions" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/h-products-dbd/kenkoukazoku-terraform"
}

