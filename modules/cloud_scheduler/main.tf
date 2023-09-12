# 新規にCloud Schedulerジョブを作成する
resource "google_cloud_scheduler_job" "main" {
  name     = var.job_name
  schedule = var.job_schedule

  # TODO: workflow作成後、ターゲットをworkflowに変更する
  http_target {
    http_method = "GET"
    uri        = "https://google.com"
  }
}