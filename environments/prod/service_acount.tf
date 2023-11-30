module "worlflow_sa" {
  source          = "../../modules/service_acount"
  project_id      = var.project_id
  sa_id           = "kenkokazoku-workflow-sa"
  sa_display_name = "Service Account for Workflow"
  sa_roles = [
    "roles/run.invoker",
    "roles/dataform.editor",
    "roles/logging.logWriter",
    "roles/workflows.invoker"
  ]
}

module "scheduler_sa" {
  source          = "../../modules/service_acount"
  project_id      = var.project_id
  sa_id           = "kenkokazoku-job-sa"
  sa_display_name = "Service Account for Scheduler"
  sa_roles = [
    "roles/workflows.invoker"
  ]
}

module "dataform_sa" {
  source          = "../../modules/service_acount"
  project_id      = var.project_id
  sa_id           = "kenkoukazoku-dataform-sa"
  sa_display_name = "Service Account for Dataform"
  sa_roles = [
    "roles/iam.serviceAccountTokenCreator",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/secretmanager.secretAccessor"
  ]
}