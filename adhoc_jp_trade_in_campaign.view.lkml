view: adhoc_jp_trade_in_campaign {
  # Used for an Ad-hoc explore. Keep
  derived_table: {
    sql: select * from products_historical_JP_test
      ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.countryCode ;;
  }

#solution for converting string values for date (in BigQuery) to a usable date format.


  dimension: partition_date {
    type: date
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', ${TABLE}.date))   ;;
  }


  dimension_group: ga {
    type: time
    datatype: yyyymmdd
    timeframes: [date, week,month, month_name, year, day_of_week]
    sql: ${TABLE}.date ;;
  }


  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.productSKU ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.productCategory ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transactionID ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension: promo_code {
    type: string
    sql: ${TABLE}.promoCode ;;
  }

  dimension: product_quantity {
    type: number
    sql: ${TABLE}.productQuantity ;;
  }

  dimension: product_revenue {
    type: number
    sql: ${TABLE}.productRevenue ;;
  }

  dimension: product_revenue_gbp {
    type: number
    value_format_name: gbp
    sql: ${product_revenue} / ${tax_xrates_by_country_2018_v2.xrate} ;;
  }

#Calculated metrics - need to change for Japanese Yen here.

  measure: total_revenue {
    type: sum
    value_format: "0.00,,\" M\""
    sql: ${product_revenue} ;;
    html: ¥{{rendered_value}} ;;
  }


  measure: total_revenue_gbp {
    label: "Transaction Revenue Total (GBP)"
    type: sum
    sql: ${product_revenue_gbp} ;;

  }

  measure: total_transactions {
    type: sum
    sql: ${product_quantity} ;;
  }


# TRCPJ7 trade in code

  measure: total_trade_in_revenue {
    group_label: "Trade in metrics (TRCPJ7)"
    type: sum
    sql: ${product_revenue} ;;
    value_format: "0.00,,\" M\""
    filters: {
      field: promo_code
      value: "TRCPJ7"
    }
    html: ¥{{rendered_value}} ;;
  }

  measure: total_trade_in_transactions {
    group_label: "Trade in metrics (TRCPJ7)"
    type: sum
    sql: ${product_quantity} ;;
    filters: {
      field: promo_code
      value: "TRCPJ7"
    }
  }

  measure: trade_in_average_order_value {
    group_label: "Trade in metrics (TRCPJ7)"
    type: number
    sql: ${total_trade_in_revenue} / ${total_trade_in_transactions} ;;
    value_format: "0"
    html: ¥{{rendered_value}} ;;
  }

  measure: average_order_value {
    type: number
    sql: ${total_revenue} / ${total_transactions} ;;
    value_format: "0"
    html: ¥{{rendered_value}} ;;
  }


# Trade in as percentage of total

  measure: trade_in_revenue_as_percent_of_total {
    group_label: "Trade in metrics (TRCPJ7)"
    type: number
    sql: ${total_trade_in_revenue} / ${total_revenue} ;;
    value_format: "0%"
  }


#Joined data metrics.



}
