module "dataform" {
  source             = "../../modules/dataform"
  project_id         = var.project_id
  project_number     = var.project_number
  location           = var.region
  # TODO: dataform_nameを自分の環境に合わせて変更する
  dataform_name      = "tosashimizu-anarisys"
  # TODO: github_urlを自分の環境に合わせて変更する
  github_url         = "git@github.com:h-products-dbd/tosashimizu-dataform.git"
  # TODO: github_public_keyを自分の環境に合わせて変更する 
  github_public_key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
  default_branch     = "main"
  dataform_secret_id = "dataform-github-token"
  sa_email           = module.dataform_sa.sa_email
  gh_private_key     = var.gh_private_key
}
