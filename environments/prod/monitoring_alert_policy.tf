module "scheduler_policy" {
  source            = "../../modules/monitoring_alert_policy"
  job_name          = module.cloud_scheduler.job_name
  alert_channel_ids = module.notification_channel.notification_channel_ids
  filter            = "resource.type=\"cloud_scheduler_job\" AND resource.labels.job_id=\"${module.cloud_scheduler.job_name}\" AND severity=\"ERROR\""
}
