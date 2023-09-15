resource "google_workflows_workflow" "main" {
  name     = var.workflow_name
  
  source_contents = join("", [
    templatefile("${path.module}/yaml/main.yaml", {})
  ])

  # TODO:ロギング考慮
}
