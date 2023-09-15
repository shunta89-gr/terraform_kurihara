resource "google_service_account" "scheduler_sa" {
  account_id   = var.scheduler_sa_id
  display_name = var.scheduler_sa_display_name
}