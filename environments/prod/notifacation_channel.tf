module "notification_channel" {
  source                    = "../../modules/notification_channel"
  notification_channel_name = "tosashimizu-alert-channel"
  notification_email_addresses = [
    "masaru.akutsu@growthdata.co.jp",
    "akira.aramaki@growthdata.co.jp",
    "yusuke.nakata@growthdata.co.jp",
    "hang.nguyenthithuy@growthdata.co.jp",
    "riku.ichihara@growthdata.co.jp"
  ]
}