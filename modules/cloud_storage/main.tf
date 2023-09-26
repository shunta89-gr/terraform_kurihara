resource "google_storage_bucket" "main" {
    name     = var.storage_name
    location = var.location
}