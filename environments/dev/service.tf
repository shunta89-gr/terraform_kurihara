module "google_project_service" {
  source = "../../modules/gcp_enable_services"
  gcp_service_list = [
    "cloudscheduler.googleapis.com",
    "workflows.googleapis.com",
    "workflowexecutions.googleapis.com"
  ]
}
