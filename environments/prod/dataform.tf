module "dataform" {
  source             = "../../modules/dataform"
  project_id         = var.project_id
  location           = var.region
  dataform_name      = "kenkokazoku"
  github_url         = "git@github.com:h-products-dbd/kenkoukazoku-dataform.git"
  github_public_key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
  default_branch     = "main"
  dataform_secret_id = "dataform-github-token"
  sa_email           = module.dataform_sa.sa_email
}
