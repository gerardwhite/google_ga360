view: products_historical_allmarkets {
  #GA agg table from before

  sql_table_name: ao_looker_test.products_historical_allmarkets ;;

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.countryCode ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

# Date calcs

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



  dimension: device_category {
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.productCategory ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_quantity {
    type: number
    sql: ${TABLE}.productQuantity ;;
  }

  dimension: product_revenue {
    type: number
    sql: ${TABLE}.productRevenue ;;
  }

#Code to currency convert when ready
#   dimension: product_revenue_gbp {
#     type: number
#     value_format_name: gbp
#     sql: ${product_revenue} / ${tax_xrates_by_country_2018_v2.xrate} ;;
#   }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.productSKU ;;
  }

  dimension: promo_code {
    type: string
    sql: ${TABLE}.promoCode ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transactionID ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

# Measures

  measure: number_of_transactions {
    type: sum
    sql: ${product_quantity} ;;
  }

  measure: total_product_revenue_local {
    type: sum
    sql: ${product_revenue} ;;
  }


# Currency conversion stuff
#   measure: total_product_revenue_gbp {
#     type: sum
#     sql: ${product_revenue_gbp} ;;
#
#   }



  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
