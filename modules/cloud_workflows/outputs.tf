output "workflow_name" {
  description = "作成したワークフローの名前"
  value       = google_workflows_workflow.main.name
}

output "workflow_id" {
  description = "作成したワークフローのID"
  value       = google_workflows_workflow.main.id
}