module "notification_channel" {
    source = "../../modules/notification_channel"
    notification_channel_name = "kenkokazoku-alert-channel"
    notification_email_address = "yukinobu.tamura@growthdata.co.jp"
}