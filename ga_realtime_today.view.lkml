view: ga_realtime_today {

  sql_table_name: ao_looker_test.ga_realtime_today ;;


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

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  measure: total_pageviews {
    type: sum
    sql: ${pageviews} ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  measure: local_revenue {
    type: sum
    sql: ${revenue} ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: upload_time {
    type: string
    sql: ${TABLE}.uploadTime ;;
  }


# Converts the BigQuery POSIX date format back to hours minutes and seconds in UTC format.
  dimension: start_time {
    type: date_time
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStartTime) ;;
  }

  dimension_group: date {
    type: time
    datatype: date
    timeframes: [date, week,month, month_name, year, day_of_week, hour_of_day, time_of_day, time]
    sql: ${start_time} ;;
  }


  # Gets the current timestamp
  dimension: time_now {
    type: date_time
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension_group: time_of_now {
    type: time
    datatype: date
    timeframes: [hour_of_day, time_of_day, hour]
    sql: ${time_now} ;;
  }


  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  measure: total_visits {
    type: sum
    sql: ${visits} ;;
  }


  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }






  measure: count {
    type: count
    drill_fields: []
  }
}
