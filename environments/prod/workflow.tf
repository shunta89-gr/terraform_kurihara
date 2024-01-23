locals {
  dollar = "$"
}

module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "tosashimizu-workflow"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/workflow.yaml.tftpl", {
    CLEANSING_WORKFLOW_ID        = module.data_cleansing_workflow.workflow_name,
    IMPORT_CSV_TO_BQ_WORKFLOW_ID = module.import_csv_to_bq_workflow.workflow_name,
    DATAFORM_WORKFLOW_ID         = module.dataform_workflow.workflow_name
  })
}

module "data_cleansing_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "data_cleansing"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/data_cleansing_workflow.yaml.tftpl", {
    CLEANSING_FUNCTION_URL = module.data_cleansing.function_uri,
    BUCKET                 = module.data-sorce-bucket.bucket_name,
    UNZIP_ENCODING         = "CP932",
    FILE_ENCODING          = "utf-8",
    files                  = "[\"めじか個人台帳.csv\",\"観光台帳.csv\",\"発行一覧.csv\",\"利用状況一覧.csv\",\"店舗一覧.csv\",\"業種別.csv\",\"utf_ken_all.csv\"]",
    dollar                 = "${local.dollar}",
    val_files              = "${local.dollar}{files}"
  })
}

module "import_csv_to_bq_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "import_csv_to_bq"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/import_csv_to_bq_workflow.yaml.tftpl", {
    IMPORT_CSV_TO_BQ_FUNCTION_URL      = module.import_csv_to_bq.function_uri,
    IMPORT_CSV_TO_BQ_INIT_FUNCTION_URL = module.import_csv_to_bq_init.function_uri,
    tables                             = "[\"personal_register\",\"sightseeing_register\",\"publication_list\",\"usage_status_list\",\"shop_list\",\"industory_list\",\"postal_code_master\"]",
    dollar                             = "${local.dollar}",
    val_tables                         = "${local.dollar}{tables}"
  })
}

module "dataform_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "dataform"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/dataform_workflow.yaml.tftpl", {
    PROJECT_ID          = var.project_id,
    REPOSITORY_LOCATION = var.region,
    REPOSITORY_ID       = module.dataform.dataform_repository_name,
    GIT_COMMITISH       = "main"
  })
}
