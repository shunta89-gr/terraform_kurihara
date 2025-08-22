module "notification_channel" {
  source                    = "../../modules/notification_channel"
  # TODO: notification_channel_nameを自分の環境に合わせて変更する
  notification_channel_name = "tosashimizu-alert-channel"
  # TODO: notification_email_addressesを自分の環境に合わせて変更する
  notification_email_addresses = [
    "masaru.akutsu@growthdata.co.jp"
  ]
}