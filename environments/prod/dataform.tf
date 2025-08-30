module "dataform" {
  source             = "../../modules/dataform"
  project_id         = var.project_id
  project_number     = var.project_number
  location           = var.region
  # TODO: dataform_nameを自分の環境に合わせて変更する
  dataform_name      = "kurihara-anarisys"
  # TODO: github_urlを自分の環境に合わせて変更する
  github_url         = "git@github.com:shunta89-gr/dataform_kurihara.git"
  # TODO: github_public_keyを自分の環境に合わせて変更する 
  github_public_key  = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACD/4Ws33w6w+TM9vdFmQuzq82bud6+D+nLaVWBvU5701FJf9NClZl6S4RFUx8L8krmG0ZjO3nv6HAwZQqPRjyPHgCTyXZ4d1lwH/DnYsBt4xZI2cp5NmC04tdpYjwtIlHLylenkdyLbwWRGUCwdxXP4GrF6+SRSGHy0RiVWUtgiApNuA== hpad1\01056521@Y22MW0012"
  default_branch     = "main"
  dataform_secret_id = "dataform-github-token"
  sa_email           = module.dataform_sa.sa_email
  gh_private_key     = var.gh_private_key
}
