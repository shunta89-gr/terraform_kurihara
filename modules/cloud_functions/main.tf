###
#
# Cloud Functionsにアップロードするファイルをzipに固める
#
###
data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
}

###
#
# zipファイルをアップする
#
###
resource "google_storage_bucket_object" "package" {
  name   = "packages/functions.${data.archive_file.function_archive.output_md5}.zip"
  bucket = var.bucket_name
  source = data.archive_file.function_archive.output_path
}

###
#
# Cloud Functionの定義(v2)
#
###
resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = var.function_region
  description = var.function_description

  build_config {
    runtime     = var.function_runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.package.name
      }
    }
  }

  service_config {
    max_instance_count = var.max_instance_count
    available_memory   = var.function_memory
    timeout_seconds    = var.timeout_seconds
  }
}

