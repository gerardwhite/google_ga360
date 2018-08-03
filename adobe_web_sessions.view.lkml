view: rt_web_sessions {
#   Fairly sure this is not being used.
#   Delete if this is the case

  sql_table_name: `dyson-digitalanalytics-sandbox.dyson_adobe.web_sessions_*` ;;

  dimension: analytics_source {
    type: string
    sql: ${TABLE}.analytics_source ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
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


# Solution to convert Adobe date format into a Looker friendly version.

  dimension: partition_date {
    type: date
    datatype: date
    sql: CAST(CAST(rt_web_sessions.date  AS TIMESTAMP) AS DATE) ;;
  }

# Builds dates out into groups:

  dimension_group: adobe {
    type: time
    datatype: date
    timeframes: [date, week,month, month_name, year, day_of_week]
    sql: ${partition_date} ;;
  }





  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.devicecategory ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: pageviews {
    hidden: yes
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: transactions {
    hidden: yes
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: visits {
    type: number
    hidden: yes
    sql: ${TABLE}.visits ;;
  }

  measure: total_visits {
    type: sum
    sql: ${visits} ;;
  }

  measure: total_transactions {
    type: sum
    sql: ${transactions} ;;
  }

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: total_pageviews {
    type: sum
    sql: ${pageviews} ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
