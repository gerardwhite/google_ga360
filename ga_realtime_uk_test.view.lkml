view: ga_realtime_uk {
  sql_table_name: ao_looker_test.ga_realtime_uk ;;

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: visit_start_time {
    type: number
    sql: ${TABLE}.visitStartTime ;;
  }

  dimension: visitors_start_time {
  type: date
  sql: TIMESTAMP_SECONDS(${visit_start_time}) ;;
  }


  dimension_group: start_time_group {
    type: time
    timeframes: [year, month, quarter, date, week, week_of_year,
      day_of_week, day_of_month, month_name, hour, hour_of_day, minute, time_of_day]
    sql: TIMESTAMP_SECONDS(${visit_start_time})  ;;
    convert_tz: no
    datatype: date
  }





  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  measure: total_visits {
    type: sum
    sql: ${visits} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
