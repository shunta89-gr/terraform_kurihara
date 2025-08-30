resource "google_iam_workload_identity_pool" "pool" {
  provider = google-beta
  project  = var.project_id

  workload_identity_pool_id = "terraform-pool"
  display_name              = "terraform-pool"
  description               = "Github Actionsで使用するためのPool"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  provider = google-beta
  project  = var.project_id

  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "terraform-pool-provider"
  display_name                       = "terraform-pool-provider"
  description                        = "Github Actionsで使用するためのProvider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

data "google_service_account" "terraform_sa" {
  account_id = "terraform@gpj-anarisys-tosashimizu.iam.gserviceaccount.com"
}
resource "google_service_account_iam_member" "github_actions" {
  service_account_id = data.google_service_account.terraform_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/shunta89-gr/terraform_kurihara"
}

