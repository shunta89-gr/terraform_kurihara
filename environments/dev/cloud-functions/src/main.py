import functions_framework
from rawdata.rawdata import RawData

def import_csv(cloud_event):
    # target_date = cloud_event.args.get('target_date', '')
    target_date = ''
    rawdata = RawData()
    rawdata.exec(target_date)
    return ("Done!\n", 200)