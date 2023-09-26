module "dataform" {
    source = "../../modules/dataform"
    
    project_id     = "dev-dbd"
    dataform_name  = "kenkokazoku"
    github_url     = "https://github.com/h-products-dbd/kenkoukazoku-dataform.git"
    default_branch = "main"
    dataform_sa_roles = [
        "roles/bigquery.dataEditor",
        "roles/bigquery.jobUser",
    ]
    dataform_secret_id = "dataform-github-token"
    authentication_token = file("../../github-token/token.txt")
    dataform_sa_id = "kenkoukazoku-dataform-sa"
    dataform_sa_display_name = "Service Account for dataform"
}