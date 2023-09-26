from datetime import datetime, timedelta, timezone

class Datelib:

    JST = timezone(timedelta(hours=+9), 'JST')

    @classmethod
    def today(cls, date_format):
        dt_now = datetime.now(cls.JST)
        return dt_now.strftime(date_format)
