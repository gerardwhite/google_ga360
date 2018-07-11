view: rt_web_sessions {
  sql_table_name: `dyson_adobe.web_sessions_*` ;;

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

  dimension: website {
    type: string
    sql: CASE WHEN ${dataset_id} = '100052885' then 'www.dyson.com'
              WHEN ${dataset_id} = '100050803' then 'www.dyson.co.uk'
              WHEN ${dataset_id} = '100050804' then 'www.dyson.ie'
              END;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: devicecategory {
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
