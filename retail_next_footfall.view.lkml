view: retail_next {
  sql_table_name: ao_looker_test.retail_next ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.hour ;;
  }


# date and time wanted here!

 dimension: date_and_time {
   sql: timestamp(concat(cast(${date_date} as string), " ", ${time}, ":00")) ;;
 }


dimension_group: date_and_times {

  type: time
  timeframes: [
    raw,
    date,
    hour,
    hour_of_day,
    day_of_week,
    week,
    month,
    quarter,
    year
  ]
  convert_tz: no
  datatype: date
  sql: ${date_and_time} ;;


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


measure: total_values {
  type: sum
  sql: ${value} ;;
}


  measure: footfall_in {
    type: sum
    sql: ${value} ;;
    filters: {
      field: metric
      value: "traffic_in"
    }
  }

  measure: footfall_out {
    type: sum
    sql: ${value} ;;
    filters: {
      field: metric
      value: "traffic_out"
    }
  }




  measure: count {
    type: count
    drill_fields: []
  }
}
