module "cloud_scheduler" {
  source               = "../../modules/cloud_scheduler"
  project_id           = var.project_id
  region               = var.region
  job_name             = "kenkokazoku-job"
  job_schedule         = "0 8 * * 1" #TODO:タイミングは決まり次第変更
  time_zone            = "Asia/Tokyo"
  target_workflow_name = module.cloud_workflow.workflow_name
  sa_email             = module.scheduler_sa.sa_email
}
