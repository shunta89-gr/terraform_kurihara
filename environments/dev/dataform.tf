module "dataform" {
    source = "../../modules/dataform"
    credentials_path = abspath("../../json-key/dev-dbd-64657934cd92.json")
    project_id     = var.project_id
    location = var.region
    dataform_name  = "kenkokazoku"
    github_url     = "git@github.com:h-products-dbd/kenkoukazoku-dataform.git"
    github_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
    default_branch = "main"
    dataform_sa_roles = [
        "roles/bigquery.dataEditor",
        "roles/bigquery.jobUser",
        "roles/secretmanager.secretAccessor"
    ]
    dataform_secret_id = "dataform-github-token"
    authentication_token = file("../../github-token/token.txt")
    dataform_sa_id = "kenkoukazoku-dataform-sa"
    dataform_sa_display_name = "Service Account for dataform"
}