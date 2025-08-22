resource "google_secret_manager_secret" "dataform_git" {
  provider  = google-beta
  secret_id = var.dataform_secret_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "dataform_git_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.dataform_git.id
  secret_data = var.gh_private_key
}

resource "google_secret_manager_secret_iam_member" "member" {
  provider  = google-beta
  secret_id = google_secret_manager_secret.dataform_git.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.sa_email}"
}

resource "google_dataform_repository" "repository" {
  provider = google-beta
  name     = var.dataform_name

  git_remote_settings {
    url            = var.github_url
    default_branch = var.default_branch
    ssh_authentication_config {
      user_private_key_secret_version = google_secret_manager_secret_version.dataform_git_version.id
      host_public_key                 = var.github_public_key
    }
  }
  
  service_account = var.sa_email
}

resource "google_secret_manager_secret_iam_member" "dataform_default_sa" {
  provider  = google-beta
  secret_id = google_secret_manager_secret.dataform_git.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${var.project_id}@gcp-sa-dataform.iam.gserviceaccount.com"
}

resource "google_service_account_iam_member" "dataform_token_creator" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.sa_email}"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${var.project_number}@gcp-sa-dataform.iam.gserviceaccount.com"
}