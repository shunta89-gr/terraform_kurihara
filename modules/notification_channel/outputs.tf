output "notification_channel_ids" {
  value       = google_monitoring_notification_channel.main.*.id
}