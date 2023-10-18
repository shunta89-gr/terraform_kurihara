resource "google_monitoring_alert_policy" "workflow-policy" {
  display_name          = "${var.workflow_name} エラー監視"
  notification_channels = [var.alert_channel_id]
  combiner              = "OR"

  conditions {
    display_name = "${var.workflow_name}-error-logs"
    condition_matched_log {
      filter = "resource.type=\"workflows.googleapis.com/Workflow\" AND resource.labels.workflow_id=\"${var.workflow_name}\" AND severity=\"ERROR\""
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s" # 5分ごとに最大で1回の通知が行われるように制限
    }
    auto_close = "604800s"
  }

  documentation {
    content = "${var.workflow_name}でエラーが発生しました。"
  }
}