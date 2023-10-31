resource "google_monitoring_notification_channel" "main" {
  count = length(var.notification_email_addresses)

  display_name = "${var.notification_channel_name}-${count.index}"
  type         = "email"
  labels = {
    email_address = element(var.notification_email_addresses, count.index)
  }
}