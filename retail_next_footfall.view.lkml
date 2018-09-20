view: retail_next {
  sql_table_name: ao_looker_test.retail_next ;;

  dimension_group: date {
    hidden: yes
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


# convert back to string so we can concat.

 dimension: date_and_time {
   sql: timestamp(concat(cast(${date_date} as string), " ", ${time}, ":00")) ;;
 }


dimension_group: date_and_times {

  type: time
  description: "Date and times in UTC format"
  timeframes: [
    raw,
    date,
    hour,
    hour_of_day,
    day_of_week,
    week,
    month,
    month_name,
    quarter,
    year
  ]
  convert_tz: no
  datatype: date
  sql: ${date_and_time} ;;

}

# Gets current time (UTC)
  dimension: time_now {
  type: date_time
  sql: CURRENT_TIMESTAMP() ;;
  }


# Adjustment factor from UTC time to local time.  Needs completing for different office locations:
# Looks like retail next may already have been converted to local times.  So use this logic for weather data.
dimension: time_zone_adjustment {
  type: number
  sql: CASE WHEN ${city} = "San Francisco" THEN -7
            WHEN ${city} = "New York" THEN -5
            WHEN ${city} = "Tokyo" THEN +9
            WHEN ${city} = "London" THEN +1
            ELSE 0
            END;;
}

# Converts hour of day into local equivalent
dimension: local_hour_of_day {
  hidden: no
  type: number
  sql: ${date_and_times_hour_of_day}+${time_zone_adjustment} ;;
}


# Converts minus amounts into 24 equivalents
dimension: local_hour_of_day24 {
  type: number
  sql: if(${local_hour_of_day}<0,(24+${local_hour_of_day}),${local_hour_of_day}) ;;

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
