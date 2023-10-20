locals {
  dollar = "$"
}

data "template_file" "workflow_template" {
  template = file("./cloud-workflows/workflow.yaml")

  vars = {
    PROJECT_ID                  = var.project_id
    REPOSITORY_LOCATION         = var.region
    REPOSITORY_ID               = module.dataform.dataform_repository_id
    CLOUD_FUNCTION_ENDPOINT_URL = module.import_csv_to_bq.function_uri
    GIT_COMMITISH               = "main"
    UNZIP_FUNCTION_URL          = module.unzip.function_uri
    UNZIP_BUCKET                = module.data-sorce-bucket.bucket_name
    UNZIP_ENCODING              = "CP932"
    CLEANSING_FUNCTION_URL      = module.data_cleansing.function_uri
    FILE_ENCODING               = "utf-8"
    files                       = "[\"顧客マスタ.csv\",\"商品マスタ.csv\",\"退会データ.csv\",\"顧客売上マスタ.csv\",\"顧客商品別売上マスタ.csv\",\"売掛データ.csv\",\"売掛明細データ.csv\",\"顧客ステージマスタ.csv\",\"顧客休眠マスタ.csv\",\"媒体マスタ.csv\",\"発送実績データ.csv\"]"
    dollar                      = "${local.dollar}"
    val_files                   = "${local.dollar}{files}"
    tables                      = "[\"customer_master\",\"product_master\",\"unsubscribe_info\",\"customer_sales_master\",\"customer_product_sales_master\",\"sales_data\",\"sales_meisai_data\",\"customer_stage_master\",\"dormant_customer\",\"media_master\",\"dempyo_send_data\"]"
    val_tables                  = "${local.dollar}{tables}"
  }
}

module "cloud_workflow" {
  source                   = "../../modules/cloud_workflows"
  project_id               = var.project_id
  workflow_name            = "kenkokazoku-workflow"
  workflow_sa_id           = "kenkokazoku-workflow-sa"
  workflow_sa_display_name = "Service Account for Workflow"
  workflow_sa_roles = [
    "roles/run.invoker",
    "roles/dataform.editor",
    "roles/logging.logWriter"
  ]
  workflow_definition = data.template_file.workflow_template.rendered
}
