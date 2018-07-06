view: gfk {
  sql_table_name: dyson_gfk_opi.global_price_parity_201805 ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.Currency ;;
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

  dimension: dyson_category {
    type: string
    sql: ${TABLE}.Dyson_Category ;;
  }

  dimension: dyson_sku {
    type: string
    sql: ${TABLE}.Dyson_SKU ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
  }

  dimension: promotion {
    type: string
    sql: ${TABLE}.Promotion ;;
  }

  dimension: retailer_name {
    type: string
    sql: ${TABLE}.Retailer_Name ;;
  }

  dimension: stock {
    type: yesno
    sql: ${TABLE}.Stock ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  measure: count {
    type: count
    drill_fields: [retailer_name, name]
  }
}
