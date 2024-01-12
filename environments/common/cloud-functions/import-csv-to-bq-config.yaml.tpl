projectId: ${project_id}
bucketName: ${bucket_name}
backupBucketName: ${backup_bucket_name}
targets:
 - path: personal_register
   fileSearchPath: "*めじか個人台帳*.csv"
   fieldDelimiter: ","
   fileEncoding: "Shift_JIS"
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
      type: DATE
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
    - name: class_coe1
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
   fileSearchPath: "*引落orb_member_points*.csv"
   fieldDelimiter: ","
   fileEncoding: "Shift_JIS" 
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
      type: STRING
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
   fileSearchPath: "*振込orb_point_uses*.csv"
   fieldDelimiter: ","
   fileEncoding: "Shift_JIS"
   dataset: common_space
   tableName: usage_status_list
   isMaster: false
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
   fileSearchPath: "観光台帳*.csv"
   fieldDelimiter: ","
   fileEncoding: "Shift_JIS"
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
    - name: phone_number
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
