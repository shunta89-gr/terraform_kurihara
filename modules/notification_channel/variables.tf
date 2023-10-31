variable "notification_channel_name" {
  description = "Notification Channelの名前"
  type        = string
}

variable "notification_email_addresses" {
  description = "Notificationの通知先メールアドレス"
  type        = list(string)
}