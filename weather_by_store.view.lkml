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
