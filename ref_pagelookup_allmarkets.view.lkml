view: view_pagelookup_allmarkets {
  #reference data/lookup
  sql_table_name: ao_looker_test.view_pagelookup_allmarkets ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.countryCode ;;
  }

  dimension: page_path {
    type: string
    sql: ${TABLE}.pagePath ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.pageUrl ;;
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
