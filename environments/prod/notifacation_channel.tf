module "notification_channel" {
  source                    = "../../modules/notification_channel"
  notification_channel_name = "kenkokazoku-alert-channel"
  notification_email_addresses = [
    "shunta.kurihara@growthdata.co.jp",
    "michizo.ujihara@growthdata.co.jp",
    "masaru.akutsu@hakuhodo.co.jp"
  ]
}