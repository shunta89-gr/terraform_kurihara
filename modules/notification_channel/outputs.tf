output "notification_channel_ids" {
  value       = [for i in google_monitoring_notification_channel.main : i.id]
}