resource "google_monitoring_notification_channel" "main" {
  display_name = var.notification_channel_name
  type         = "email"
  labels = {
    email_address = var.notification_email_address
  }
}
