locals {
  dollar = "$"
}

module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "tosashimizu-workflow"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/workflow.yaml.tftpl", {
    UNZIP_WORKFLOW_ID            = module.unzip_workflow.workflow_name,
    CLEANSING_WORKFLOW_ID        = module.data_cleansing_workflow.workflow_name,
    IMPORT_CSV_TO_BQ_WORKFLOW_ID = module.import_csv_to_bq_workflow.workflow_name,
    DATAFORM_WORKFLOW_ID         = module.dataform_workflow.workflow_name
  })
}

module "unzip_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "unzip"
  workflow_service_account = module.worlflow_sa.sa_email
  workflow_definition = templatefile("../common/cloud-workflows/unzip_workflow.yaml.tftpl", {
    UNZIP_FUNCTION_URL  = module.unzip.function_uri,
    UNZIP_BUCKET        = module.data-sorce-bucket.bucket_name,
    UNZIP_BACKUP_BUCKET = module.data-sorce-backup-bucket.bucket_name,
    UNZIP_ENCODING      = "CP932"
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
    files                  = "[\"顧客マスタ.csv\",\"商品マスタ.csv\",\"退会データ.csv\",\"顧客売上マスタ.csv\",\"顧客商品別売上マスタ.csv\",\"売掛データ.csv\",\"売掛明細データ.csv\",\"顧客ステージマスタ.csv\",\"顧客休眠マスタ.csv\",\"媒体マスタ.csv\",\"発送実績データ.csv\"]",
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
    tables                             = "[\"customer_master\",\"product_master\",\"unsubscribe_info\",\"customer_sales_master\",\"customer_product_sales_master\",\"sales_data\",\"sales_meisai_data\",\"customer_stage_master\",\"dormant_customer\",\"media_master\",\"dempyo_send_data\"]",
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
