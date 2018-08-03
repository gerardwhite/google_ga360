view: view_pages_last30days_allmarkets {
  #GA agg table from before
  sql_table_name: ao_looker_test.view_pages_last30days_allmarkets ;;

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

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

# Date calcs

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


  dimension: lands {
    type: number
    sql: ${TABLE}.lands ;;
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


#measures

  measure: number_of_oos_visits {
    type: sum
    sql: ${oos_visits} ;;
  }

  measure: number_of_visits {
    type: sum
    sql: ${visits} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
