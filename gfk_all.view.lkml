view: gfk_all {
  derived_table: {
    sql_trigger_value: select current_date ;;
    sql: SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201802`
      UNION ALL
      SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201803`
      UNION ALL
      SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201804`
      UNION ALL
      SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201805`
      UNION ALL
      SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201806`
      UNION ALL
      SELECT * FROM `dyson-digitalanalytics-sandbox.dyson_gfk_opi.global_price_parity_201807`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: country {
    type: string
    sql: ${TABLE}.Country ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: dyson_sku {
    type: string
    sql: ${TABLE}.Dyson_SKU ;;
  }

  dimension: dyson_category {
    type: string
    sql: ${TABLE}.Dyson_Category ;;
  }

  dimension: retailer_name {
    type: string
    sql: ${TABLE}.Retailer_Name ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.Currency ;;
  }

  dimension: stock {
    type: string
    sql: ${TABLE}.Stock ;;
  }

  dimension: promotion {
    type: string
    sql: ${TABLE}.Promotion ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  dimension_group: date_collected {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date_Collected ;;
  }

  set: detail {
    fields: [
      country,
      name,
      dyson_sku,
      dyson_category,
      retailer_name,
      price,
      currency,
      stock,
      promotion,
      url,
      date_collected_time
    ]
  }
}
