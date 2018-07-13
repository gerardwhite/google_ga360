view: view_pages_historical_allmarkets_ga {
  sql_table_name: ao_looker_test.view_pages_historical_allmarkets_ga ;;

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

  dimension: oos_visits {
    type: number
    sql: ${TABLE}.oos_visits ;;
  }

  dimension: page_path {
    type: string
    sql: ${TABLE}.pagePath ;;
  }

  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: website_id {
    type: string
    sql: ${TABLE}.websiteID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
