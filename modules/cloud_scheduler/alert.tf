resource "google_monitoring_alert_policy" "scheduler-policy" {
  display_name          = "${var.job_name} エラー監視"
  notification_channels = var.alert_channel_ids
  combiner              = "OR"

  conditions {
    display_name = "${var.job_name}-error-logs"
    condition_matched_log {
      filter = "resource.type=\"cloud_scheduler_job\" AND resource.labels.job_id=\"${var.job_name}\" AND severity=\"ERROR\""
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s" # 5分ごとに最大で1回の通知が行われるように制限
    }
    auto_close = "604800s"
  }

  documentation {
    content = "${var.job_name}でエラーが発生しました。"
  }
}
