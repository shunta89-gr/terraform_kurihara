import unicodedata
from datetime import datetime, timedelta, timezone
import re
import os

class Util:
    @staticmethod
    def convert_to_halfwidth(text):
        return unicodedata.normalize('NFKC', text)

    @staticmethod
    def remove_space(text:str):
        return text.replace(' ', '')

    @staticmethod
    def change_date_delimiter(text):
        return text.replace('/', '-')

    @staticmethod
    def modify_year(text):
        if Util.search(r'[0-9][0-9]-[0-9][0-9]-[0-9][0-9]', text) == None:
            raise ValueError("フォーマットが正しくありません。確認してください[{}]".format(text))
        
        JST = timezone(timedelta(hours=+9), 'JST')
        now_yy = datetime.now(JST).strftime("%y")
        source_yy = text[:2]
        if int(now_yy) >= int(source_yy):
            return "20" + text
        else:
            return "19" + text

    @staticmethod
    def modify_time(text):
        delimiter_count = text.count(":")
        
        if delimiter_count == 1:
            tt = datetime.strptime(text, "%H:%M")
        elif delimiter_count == 2:
            tt = datetime.strptime(text, "%H:%M:%S")
        else:
            return "00:00:00"
        
        return tt.strftime("%H:%M:%S")

    @staticmethod
    def replace_matched_string(pattern, replacement, text):
        return re.sub(pattern, replacement, text)

    @staticmethod
    def search(pattern, text):
        return re.search(pattern, text)
    
    @staticmethod
    def get_filename_from_filepath(file_path):
        return os.path.basename(file_path)
    
    @staticmethod
    def create_year(text):
        return text[:4]
