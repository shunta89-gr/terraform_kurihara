module "cloud_scheduler" {
  source                    = "../../modules/cloud_scheduler"
  project_id                = var.project_id
  region                    = var.region
  job_name                  = "kenkokazoku-job"
  job_schedule              = "0 0 1 * *" #TODO:タイミングは決まり次第変更
  scheduler_sa_id           = "kenkokazoku-job-executer"
  scheduler_sa_display_name = "Service Account for Scheduler"
  scheduler_sa_roles = [
    "roles/workflows.executor"
  ]
  target_workflow_name = "kenkokazoku-workflow"
}
