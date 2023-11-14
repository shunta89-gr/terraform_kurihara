resource "google_storage_bucket" "main" {
  name          = var.storage_name
  location      = var.location
  force_destroy = var.force_destroy
}