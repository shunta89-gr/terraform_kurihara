from rawdata.rawdata import RawData

def execute(cloud_event):
    #パラメータよりbucket_name, file_name, file-encodingを取得する
    request_args = cloud_event.args
    request_json = cloud_event.get_json(silent=True)
    target_date = ''
    if 'target_table' in request_args:
        target_table = request_args.get('target_table')
        if 'target_date' in request_args:
            target_date = request_args.get('target_date')
    elif 'target_table' in request_json:
        target_table = request_json.get('target_table')
        if 'target_date' in request_json:
            target_date = request_json.get('target_date')        
    else:
        return "パラメータの指定に誤りがあります", 400
    
    print("---- target_date = {}".format(target_date))
    rawdata = RawData()
    rawdata.exec(target_date, target_table)
    return ("completed successfully\n", 200)

def init(cloud_event):
    rawdata = RawData()
    rawdata.make_dataset()
    return ("completed successfully\n", 200)