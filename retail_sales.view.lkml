view: retail {
  sql_table_name: ao_looker_test.Retail ;;

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.Currency_Code ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: device_name {
    type: string
    sql: ${TABLE}.DeviceName ;;
  }

  dimension: gross {
    type: number
    sql: ${TABLE}.Gross ;;
  }

  dimension: gross_gbp {
    type: number
    sql: ${TABLE}.Gross_GBP ;;
  }

  dimension: item_description {
    type: string
    sql: ${TABLE}.ItemDescription ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: net_rev {
    type: number
    sql: ${TABLE}.Net_Rev ;;
  }

  dimension: net_rev1 {
    type: number
    sql: ${TABLE}.Net_Rev1 ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension: store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  dimension: store_type {
    type: string
    sql: ${TABLE}.Store_Type ;;
  }

  dimension: unique_code {
    type: string
    sql: ${TABLE}.Unique_Code ;;
  }

  dimension: week_and_year {
    type: string
    sql: ${TABLE}.Week_and_Year ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: total_revenue {
    label: "Retail Sales"
    type: sum
    value_format_name: gbp_0
    sql: ${gross_gbp} ;;
  }


  measure: count {
    type: count
    drill_fields: [device_name]
  }
}
