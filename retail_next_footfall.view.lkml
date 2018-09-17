view: retail_next {
  sql_table_name: ao_looker_test.retail_next ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: hour {
    type: string
    sql: ${TABLE}.hour ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: store {
    type: string
    sql: CASE
    WHEN ${location} = "London" then "Oxford Street"
    WHEN ${location} = "Tyson's Corner" then "Tysons Corner"
    ELSE ${location}
    END
    ;;
  }


  dimension: city {
    type: string
    sql: CASE
          WHEN ${location} = "Yorkdale Mall" then "Toronto"
          WHEN ${location} = "Tyson's Corner" then "Arlington"
          ELSE ${location}
          END
          ;;
  }



  dimension: metric {
    type: string
    sql: ${TABLE}.metric ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
