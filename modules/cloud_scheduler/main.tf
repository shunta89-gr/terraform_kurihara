# 新規にCloud Schedulerジョブを作成する
resource "google_cloud_scheduler_job" "main" {
  name      = var.job_name
  schedule  = var.job_schedule
  time_zone = var.time_zone

  http_target {
    http_method = "POST"
    uri         = "https://workflowexecutions.googleapis.com/v1/projects/${var.project_id}/locations/${var.region}/workflows/${var.target_workflow_name}/executions"

    oauth_token {
      service_account_email = var.sa_email
    }
  }
}