module "workload_identity" {
  source     = "../../modules/workload_identity"
  project_id = var.project_id
}