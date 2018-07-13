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
    hidden: yes
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: oos_visits {
    hidden: yes
    type: number
    sql: ${TABLE}.oos_visits ;;
  }

  dimension: page_path {
    type: string
    sql: ${TABLE}.pagePath ;;
  }

  dimension: visits {
    hidden: yes
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


  measure: out_of_stock_events {
    type: sum
    sql: ${oos_visits} ;;
  }

  measure: total_visits {
    type: sum
    sql: ${visits} ;;
  }


  dimension: partition_date {
    type: date
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', ${TABLE}.date))   ;;
  }


  dimension_group: ga {
    type: time
    datatype: yyyymmdd
    timeframes: [date, week,month, month_name, year, day_of_week]
    sql: ${TABLE}.date ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
