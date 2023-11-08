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
  secret_data = var.authentication_token
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
    url                                 = var.github_url
    default_branch                      = var.default_branch
    authentication_token_secret_version = google_secret_manager_secret_version.dataform_git_version.id
  }

  # 暫定対応：GCP REST APIでホストのSSH公開鍵の設定する
  provisioner "local-exec" {
    command = <<EOF
    GOOGLE_APPLICATION_CREDENTIALS=${var.credentials_path} &&
    curl https://dataform.googleapis.com/v1beta1/projects/${var.project_id}/locations/${var.location}/repositories/${var.dataform_name} \
        -X PATCH \
        -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
        -H 'Content-Type: application/json' \
        -d "{'gitRemoteSettings':{'url':'${var.github_url}','default_branch':'${var.default_branch}','sshAuthenticationConfig':{'userPrivateKeySecretVersion':'${google_secret_manager_secret_version.dataform_git_version.name}','hostPublicKey':'${var.github_public_key}'}}}"
    EOF
  }
}
