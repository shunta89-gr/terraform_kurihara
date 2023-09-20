import functions_framework
from rawdata.rawdata import RawData

def import_csv(cloud_event):
    target_date = ''
    request_args = cloud_event.args
    request_json = cloud_event.get_json(silent=True)
    
    if request_args and 'target_date' in request_args:
        target_date = request_args.get('target_date')
    elif request_json and 'target_date' in request_json:
        target_date = request_json.get('target_date')
    else:
        target_date = ''
    print("---- target_date = {}".format(target_date))
    rawdata = RawData()
    rawdata.exec(target_date)
    return ("Done!\n", 200)