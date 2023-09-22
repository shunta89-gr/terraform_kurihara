output "workflow_name" {
  description = "作成したワークフローの名前"
  value       = google_workflows_workflow.main.name
}