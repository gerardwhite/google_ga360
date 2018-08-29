view: adobe_product_performance {
#   Fairly sure this is not being used.
#   Delete if this is the case

  sql_table_name: `dyson-digitalanalytics-sandbox.dyson_adobe_us.product_performance` ;;

  dimension: analytics_source {
    type: string
    sql: ${TABLE}.analytics_source ;;
  }


  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


  dimension: dataset_id {
    type: string
    sql: ${TABLE}.dataset_id ;;
  }


# Correct dataset IDs by website
  dimension: website {
    type: string
    sql: CASE WHEN ${dataset_id} = '100052885' then 'www.dyson.com'
              WHEN ${dataset_id} = '100050803' then 'www.dyson.co.uk'
              WHEN ${dataset_id} = '100050804' then 'www.dyson.ie'
              END;;
  }


  dimension: devicecategory {
    type: string
    sql: ${TABLE}.devicecategory ;;
  }


  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }



# Solution to convert Adobe date format into a Looker friendly version.
  dimension: partition_date {
    type: date
    datatype: date
    sql: CAST(CAST(adobe_product_performance.date  AS TIMESTAMP) AS DATE) ;;
  }

# Builds dates out into groups:
  dimension_group: adobe {
    type: time
    datatype: date
    timeframes: [date, week,month, month_name, year, day_of_week]
    sql: ${partition_date} ;;
  }


  dimension: productname {
    type: string
    sql: ${TABLE}.productname ;;
  }

  dimension: productsku {
    type: string
    sql: ${TABLE}.productsku ;;
  }

  dimension: productcategory {
    type: string
    sql: ${TABLE}.productcategory ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
    link: {
      label: "View Dyson page"
      url: "{{ value }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/dyson-fav.ico"
    }
  }


  dimension: pageviews {
    hidden: yes
    type: number
    sql: ${TABLE}.pageviews ;;
  }


  dimension: sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.sessions ;;
  }


  dimension: landings {
    hidden: yes
    type: number
    sql: ${TABLE}.landings ;;
  }


  dimension: bounces {
    hidden: yes
    type: number
    sql: ${TABLE}.bounces ;;
  }


  dimension: sessions_oos {
    hidden: yes
    type: number
    sql: ${TABLE}.sessions_oos ;;
  }


  dimension: sessions_atb {
    hidden: yes
    type: number
    sql: ${TABLE}.sessions_atb ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: productrevenue {
    hidden: yes
    type: number
    sql: ${TABLE}.productrevenue ;;
  }

  dimension: dyson_price {
    hidden: yes
    type: number
    sql: ${TABLE}.dyson_price ;;
  }


# Need to build out metrics here.

measure: total_pageviews {
  type: sum
  sql: ${pageviews} ;;
}

  measure: total_sessions {
    type: sum
    sql: ${sessions} ;;
  }

  measure: total_landings {
    type: sum
    sql: ${landings} ;;
  }

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: out_of_stock_events {
    type: sum
    sql: ${sessions_oos} ;;
  }

  measure: add_to_basket_events {
    type: sum
    sql: ${sessions_atb} ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
  }

  measure: product_revenue_local {
    type: sum
    sql: ${productrevenue} ;;
  }

  measure: product_revenue_usd {
    type: sum
    value_format_name: usd_0
    sql: ${productrevenue} ;;
  }

  measure: dyson_price_average {
    type: average
    sql: ${dyson_price} ;;
  }

# Copy of Dyson price but with $ sign added
  measure: dyson_price_average_usd {
    type: average
    value_format_name: usd_0
    sql: ${dyson_price} ;;
  }



  measure: dyson_price_min {
    type: min
    sql: ${dyson_price} ;;
  }


  measure: dyson_price_min_usd {
    type: min
    value_format_name: usd_0
    sql: ${dyson_price} ;;
  }

  measure: conversion_rate {
    value_format_name: percent_2
    type: number
    description: "Transactions / Sessions"
    sql: ${total_quantity}/${total_sessions}  ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
