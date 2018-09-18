view: weather_by_store {
  sql_table_name: ao_looker_test.weather_by_store ;;

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: general_desc {
    type: string
    sql: ${TABLE}.generalDesc ;;
  }

  dimension: humidity {
    type: number
    sql: ${TABLE}.Humidity ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: pressure {
    type: number
    sql: ${TABLE}.Pressure ;;
  }

  dimension: store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  dimension: temperature {
    type: number
    sql: ${TABLE}.Temperature ;;
  }

  dimension_group: time_of_entry {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.time_of_entry AS TIMESTAMP) ;;
  }


# Gets current time (UTC)
  dimension: time_now {
    type: date_time
    sql: CURRENT_TIMESTAMP() ;;
  }


  dimension_group: current_time {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      hour,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CURRENT_TIMESTAMP() ;;
  }




# Adjustment factor from UTC time to local time.  Needs completing for different office locations:
# Looks like retail next may already have been converted to local times.  So use this logic for weather data.
  dimension: time_zone_adjustment {
    type: number
    sql: CASE WHEN ${city} = "San Francisco" THEN -7
            WHEN ${city} = "New York" THEN -5
            WHEN ${city} = "Tokyo" THEN +9
            WHEN ${city} = "London" THEN +9
            ELSE 0
            END;;
  }

# Converts hour of day into local equivalent
  dimension: local_hour_of_day {
    hidden: no
    type: number
    sql: ${time_of_entry_hour_of_day}+${time_zone_adjustment} ;;
  }


# Converts minus amounts into 24 equivalents
  dimension: local_hour_of_day24 {
    type: number
    sql: if(${local_hour_of_day}<0,(24+${local_hour_of_day}),${local_hour_of_day}) ;;

  }



 # Need to ask Gerard about UTC to regional timezones.
  dimension: local_time_now {
    type: date_time
    sql: DATE_ADD(${time_now}, ${time_zone_adjustment}, "HOUR") ;;
  }



  dimension: visibility {
    type: string
    sql: ${TABLE}.Visibility ;;
  }

  dimension: wind_desc {
    type: string
    sql: ${TABLE}.windDesc ;;
  }

  dimension: wind_speed {
    type: number
    sql: ${TABLE}.windSpeed ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
