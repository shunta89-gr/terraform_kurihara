module "notification_channel" {
    source = "../../modules/notification_channel"
    notification_channel_name = "kenkokazoku-alert-channel"
    notification_email_addresses = [
        "yukinobu.tamura@growthdata.co.jp",
        "masaru.akutsu@hakuhodo.co.jp"
    ]
}