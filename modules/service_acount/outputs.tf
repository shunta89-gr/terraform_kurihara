output "sa_email" {
    description = "作成したサービスアカウントのメールアドレス"
    value = google_service_account.main.email
}