module "cloud_scheduler" {
  source               = "../../modules/cloud_scheduler"
  project_id           = var.project_id
  region               = var.region
  # TODO: job_nameを自分の環境に合わせて変更する
  job_name             = "kurihara-job"
  job_schedule         = "0 0 * * 3" #TODO:タイミングは決まり次第変更
  time_zone            = "Asia/Tokyo"
  target_workflow_name = module.cloud_workflow.workflow_name
  sa_email             = module.scheduler_sa.sa_email
}
