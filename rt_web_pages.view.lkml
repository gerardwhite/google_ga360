view: rt_web_pages {
  sql_table_name: dyson_adobe.rt_web_pages ;;

  dimension: add_to_basket {
    type: number
    sql: ${TABLE}.add_to_basket ;;
  }

  dimension: analytics_source {
    type: string
    sql: ${TABLE}.analytics_source ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: dataset_id {
    type: string
    sql: ${TABLE}.dataset_id ;;
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

  dimension: landings {
    type: number
    sql: ${TABLE}.landings ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: sessions_atb {
    type: number
    sql: ${TABLE}.sessions_atb ;;
  }

  dimension: sessions_oos {
    type: number
    sql: ${TABLE}.sessions_oos ;;
  }

  dimension: virtualpagepath {
    type: string
    sql: ${TABLE}.virtualpagepath ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
