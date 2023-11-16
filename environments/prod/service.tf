module "google_project_service" {
  source = "../../modules/gcp_enable_services"
  gcp_service_list = [
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "secretmanager.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudscheduler.googleapis.com",
    "workflows.googleapis.com",
    "workflowexecutions.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ]
}
