resource "google_project_service" "gcp_services" {
  for_each                   = toset(var.gcp_service_list)
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
}
