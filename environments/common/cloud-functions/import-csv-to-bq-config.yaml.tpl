projectId: ${project_id}
bucketName: ${bucket_name}
backupBucketName: ${backup_bucket_name}
targets:
 - path: personal_register
   fileSearchPath: "めじか個人台帳.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: personal_register
   isMaster: true
   schema: 
    - name: task_code
      type: STRING
      mode: NULLABLE
    - name: task_name
      type: STRING
      mode: NULLABLE
    - name: ledger_num
      type: STRING
      mode: NULLABLE
    - name: year
      type: STRING
      mode: NULLABLE
    - name: administration_code
      type: STRING
      mode: NULLABLE
    - name: household_num
      type: STRING
      mode: NULLABLE
    - name: relationship_code
      type: STRING
      mode: NULLABLE
    - name: user_num
      type: STRING
      mode: NULLABLE
    - name: user_name
      type: STRING
      mode: NULLABLE
    - name: user_name_kana
      type: STRING
      mode: NULLABLE
    - name: birth_date
      type: DATE
      mode: NULLABLE
    - name: age
      type: INTEGER
      mode: NULLABLE
    - name: gender
      type: STRING
      mode: NULLABLE
    - name: postal_code
      type: STRING
      mode: NULLABLE
    - name: address1
      type: STRING
      mode: NULLABLE
    - name: address2
      type: STRING
      mode: NULLABLE    
    - name: address3
      type: STRING
      mode: NULLABLE
    - name: class_code1
      type: STRING
      mode: NULLABLE
    - name: class_name1
      type: STRING
      mode: NULLABLE
    - name: class_code2
      type: STRING
      mode: NULLABLE
    - name: class_name2
      type: STRING
      mode: NULLABLE
    - name: remarks1
      type: STRING
      mode: NULLABLE
    - name: remarks2
      type: STRING
      mode: NULLABLE    
    - name: collection_end
      type: STRING
      mode: NULLABLE
    - name: card
      type: STRING
      mode: NULLABLE
    - name: apps
      type: STRING
      mode: NULLABLE
    - name: phone_number
      type: STRING
      mode: NULLABLE
    - name: integrator
      type: STRING
      mode: NULLABLE
    - name: integrations_num
      type: STRING
      mode: NULLABLE
    - name: transferor
      type: STRING
      mode: NULLABLE
    - name: registation_date
      type: DATE
      mode: NULLABLE
    - name: delete_date
      type: DATE
      mode: NULLABLE
    - name: reason_for_change
      type: STRING
      mode: NULLABLE
    - name: any_item10
      type: STRING
      mode: NULLABLE
 - path: publication_list
   fileSearchPath: "発行一覧.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8" 
   dataset: common_space
   tableName: publication_list
   isMaster: true
   schema: 
    - name: id
      type: STRING
      mode: NULLABLE
    - name: area_name
      type: STRING
      mode: NULLABLE
    - name: member_id
      type: STRING
      mode: NULLABLE
    - name: member_code
      type: STRING
      mode: NULLABLE
    - name: member_type
      type: STRING
      mode: NULLABLE
    - name: publish_type
      type: STRING
      mode: NULLABLE
    - name: reason_type
      type: STRING
      mode: NULLABLE
    - name: point_name
      type: STRING
      mode: NULLABLE
    - name: shop_id
      type: STRING
      mode: NULLABLE
    - name: shop_name
      type: STRING
      mode: NULLABLE
    - name: event_name
      type: STRING
      mode: NULLABLE
    - name: currency_num
      type: INTEGER
      mode: NULLABLE
    - name: start_date
      type: DATETIME
      mode: NULLABLE
    - name: effective_date
      type: DATETIME
      mode: NULLABLE
    - name: operation_user
      type: STRING
      mode: NULLABLE
    - name: remarks
      type: STRING
      mode: NULLABLE
    - name: charge_id
      type: STRING
      mode: NULLABLE
 - path: usage_status_list
   fileSearchPath: "利用状況一覧.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: usage_status_list
   isMaster: true
   schema: 
    - name: use_id
      type: STRING
      mode: NULLABLE
    - name: use_date
      type: DATETIME
      mode: NULLABLE
    - name: use_type
      type: STRING
      mode: NULLABLE
    - name: use_num
      type: INTEGER
      mode: NULLABLE
    - name: status
      type: STRING
      mode: NULLABLE
    - name: member_id
      type: STRING
      mode: NULLABLE    
    - name: member_code
      type: STRING
      mode: NULLABLE    
    - name: area_name
      type: STRING
      mode: NULLABLE
    - name: point_name
      type: STRING
      mode: NULLABLE
    - name: business_id
      type: STRING
      mode: NULLABLE    
    - name: business_name
      type: STRING
      mode: NULLABLE    
    - name: shop_id
      type: STRING
      mode: NULLABLE
    - name: shop_name
      type: STRING
      mode: NULLABLE    
    - name: shop_category
      type: STRING
      mode: NULLABLE    
    - name: casher_name
      type: STRING
      mode: NULLABLE
 - path: sightseeing_register
   fileSearchPath: "観光台帳.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: sightseeing_register
   isMaster: true
   schema: 
    - name: member_id
      type: STRING
      mode: NULLABLE
    - name: member_type
      type: STRING
      mode: NULLABLE
    - name: member_code
      type: STRING
      mode: NULLABLE
    - name: name_sei
      type: STRING
      mode: NULLABLE
    - name: name_mei
      type: STRING
      mode: NULLABLE
    - name: name_sei_kana
      type: STRING
      mode: NULLABLE
    - name: name_mei_kana
      type: STRING
      mode: NULLABLE
    - name: phone_number
      type: STRING
      mode: NULLABLE
    - name: mail_address
      type: STRING
      mode: NULLABLE
    - name: postal_code
      type: STRING
      mode: NULLABLE
    - name: address1
      type: STRING
      mode: NULLABLE
    - name: address2
      type: STRING
      mode: NULLABLE
    - name: address3
      type: STRING
      mode: NULLABLE
    - name: address4
      type: STRING
      mode: NULLABLE
    - name: birth_date
      type: DATE
      mode: NULLABLE
    - name: gender
      type: STRING
      mode: NULLABLE
    - name: memo
      type: STRING
      mode: NULLABLE
    - name: rank
      type: STRING
      mode: NULLABLE
    - name: total_money_point
      type: STRING
      mode: NULLABLE
    - name: registation_datetime
      type: DATETIME
      mode: NULLABLE
  - path: shop_list
   fileSearchPath: "店舗一覧.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: shop_list
   isMaster: true
   schema: 
    - name: shop_name
      type: STRING
      mode: NULLABLE
    - name: industory_code
      type: STRING
      mode: NULLABLE
    - name: charge_flg
      type: STRING
      mode: NULLABLE
  - path: industory_list
   fileSearchPath: "業種別.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: industory_list
   isMaster: true
   schema: 
    - name: industory_code
      type: STRING
      mode: NULLABLE
    - name: industory_name
      type: STRING
      mode: NULLABLE
  - path: postal_code_master
   fileSearchPath: "utf_ken_all.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: postal_code_master
   isMaster: true
   schema: 
    - name: area_code
      type: STRING
      mode: NULLABLE
    - name: old_postal_code
      type: STRING
      mode: NULLABLE
    - name: postal_code
      type: STRING
      mode: NULLABLE
    - name: address1_kana
      type: STRING
      mode: NULLABLE
    - name: address2_kana
      type: STRING
      mode: NULLABLE
    - name: address3_kana
      type: STRING
      mode: NULLABLE
    - name: address1
      type: STRING
      mode: NULLABLE
    - name: address2
      type: STRING
      mode: NULLABLE
    - name: address3
      type: STRING
      mode: NULLABLE
    - name: others1
      type: STRING
      mode: NULLABLE
    - name: others2
      type: STRING
      mode: NULLABLE
    - name: others3
      type: STRING
      mode: NULLABLE
    - name: others4
      type: STRING
      mode: NULLABLE
    - name: others5
      type: STRING
      mode: NULLABLE
    - name: others6
      type: STRING
      mode: NULLABLE
