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
    - name: agender
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
      type: DATE
      mode: NULLABLE
    - name: effective_date
      type: DATE
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
      type: DATE
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
 - path: customer_sales_master
   fileSearchPath: "顧客売上マスタ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: customer_sales_master
   isMaster: true
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
    - name: total_sales
      type: FLOAT
      mode: NULLABLE
    - name: total_tax
      type: FLOAT
      mode: NULLABLE
    - name: total_others
      type: FLOAT
      mode: NULLABLE
    - name: total_buy_count
      type: INTEGER
      mode: NULLABLE
    - name: first_send_date
      type: STRING
      mode: NULLABLE
    - name: first_send_month
      type: STRING
      mode: NULLABLE
    - name: last_send_date
      type: STRING
      mode: NULLABLE
    - name: last_send_month
      type: STRING
      mode: NULLABLE
 - path: customer_product_sales_master
   fileSearchPath: "顧客商品別売上マスタ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: customer_product_sales_master
   isMaster: true
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
    - name: product_id
      type: STRING
      mode: REQUIRED
    - name: total_sales
      type: FLOAT
      mode: NULLABLE
    - name: total_tax
      type: FLOAT
      mode: NULLABLE
    - name: total_others
      type: FLOAT
      mode: NULLABLE
    - name: total_buy_count
      type: INTEGER
      mode: NULLABLE
    - name: total_product_count
      type: INTEGER
      mode: NULLABLE
    - name: first_send_date
      type: STRING
      mode: NULLABLE
    - name: first_send_month
      type: STRING
      mode: NULLABLE
    - name: last_send_date
      type: STRING
      mode: NULLABLE
    - name: last_send_month
      type: STRING
      mode: NULLABLE
    - name: sub_start_date
      type: STRING
      mode: NULLABLE
    - name: sub_start_month
      type: STRING
      mode: NULLABLE
    - name: sub_end_date
      type: STRING
      mode: NULLABLE
    - name: sub_end_month
      type: STRING
      mode: NULLABLE
    - name: first_sub_start_date
      type: STRING
      mode: NULLABLE
    - name: first_sub_start_month
      type: STRING
      mode: NULLABLE
 - path: sales_data
   fileSearchPath: "売掛データ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: sales_data
   isMaster: true
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
    - name: dempyo_id
      type: STRING
      mode: REQUIRED
    - name: send_date
      type: DATE
      mode: NULLABLE
    - name: send_month
      type: STRING
      mode: NULLABLE
    - name: subtotal
      type: FLOAT
      mode: NULLABLE
    - name: tax
      type: FLOAT
      mode: NULLABLE
    - name: shipping_fee
      type: FLOAT
      mode: NULLABLE
    - name: cash_on_delivery
      type: FLOAT
      mode: NULLABLE
    - name: others
      type: FLOAT
      mode: NULLABLE
    - name: total
      type: FLOAT
      mode: NULLABLE
    - name: payment_method
      type: STRING
      mode: NULLABLE
    - name: discount
      type: FLOAT
      mode: NULLABLE
    - name: order_method
      type: STRING
      mode: NULLABLE
 - path: sales_meisai_data
   fileSearchPath: "売掛明細データ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: sales_meisai_data
   isMaster: true
   schema: 
    - name: dempyo_id
      type: STRING
      mode: REQUIRED
    - name: row_num
      type: INTEGER
      mode: REQUIRED
    - name: cycle
      type: STRING
      mode: NULLABLE
    - name: product_id
      type: STRING
      mode: NULLABLE
    - name: quantity
      type: INTEGER
      mode: NULLABLE
    - name: service_code
      type: STRING
      mode: NULLABLE
    - name: unit_price
      type: FLOAT
      mode: NULLABLE
    - name: subtotal
      type: FLOAT
      mode: NULLABLE
    - name: tax
      type: FLOAT
      mode: NULLABLE
    - name: shipping_fee
      type: FLOAT
      mode: NULLABLE
    - name: others
      type: FLOAT
      mode: NULLABLE
    - name: discount
      type: FLOAT
      mode: NULLABLE
 - path: customer_stage_master
   fileSearchPath: "顧客ステージマスタ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: customer_stage_master
   isMaster: true
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
    - name: stage_code
      type: INTEGER
      mode: NULLABLE
    - name: stage_title
      type: STRING
      mode: NULLABLE
 - path: dormant_customer
   fileSearchPath: "顧客休眠マスタ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: dormant_customer
   isMaster: false
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
 - path: media_master
   fileSearchPath: "媒体マスタ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: media_master
   isMaster: true
   schema: 
    - name: media_id
      type: STRING
      mode: REQUIRED
    - name: media_name
      type: STRING
      mode: NULLABLE
    - name: ad_series
      type: STRING
      mode: NULLABLE
    - name: area
      type: STRING
      mode: NULLABLE
    - name: ad_amount
      type: FLOAT
      mode: NULLABLE
    - name: copy_num
      type: INTEGER
      mode: NULLABLE
    - name: ad_date
      type: DATE
      mode: NULLABLE
    - name: start_time
      type: TIME
      mode: NULLABLE
    - name: end_time
      type: TIME
      mode: NULLABLE
    - name: program_name
      type: STRING
      mode: NULLABLE
    - name: time_length
      type: STRING
      mode: NULLABLE
    - name: ad_product
      type: STRING
      mode: NULLABLE
    - name: genkou_id
      type: STRING
      mode: NULLABLE
    - name: offer_message
      type: STRING
      mode: NULLABLE
 - path: dempyo_send_data
   fileSearchPath: "発送実績データ.csv"
   fieldDelimiter: ","
   fileEncoding: "utf-8"
   dataset: common_space
   tableName: dempyo_send_data
   isMaster: true
   schema: 
    - name: customer_id
      type: STRING
      mode: REQUIRED
    - name: dempyo_id
      type: STRING
      mode: REQUIRED
    - name: send_date
      type: DATE
      mode: NULLABLE
    - name: media_id
      type: STRING
      mode: NULLABLE