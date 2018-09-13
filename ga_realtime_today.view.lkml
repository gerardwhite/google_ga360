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

  dimension: visit_start_time {
    type: number
    sql: ${TABLE}.visitStartTime ;;
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
