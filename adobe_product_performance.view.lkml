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


# Need to build out metrics here.

measure: total_pageviews {
  type: sum
  sql: ${pageviews} ;;
}

  measure: count {
    type: count
    drill_fields: []
  }
}
