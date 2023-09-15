module "cloud_scheduler" {
  source     = "../../modules/cloud_scheduler"
  project_id = var.project_id
  region     = var.region
}