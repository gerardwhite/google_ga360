view: robot_reference_data {
  sql_table_name: ao_looker_test.robot_reference_data ;;

  dimension: average_humidity {
    type: number
    sql: ${TABLE}.averageHumidity ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: gdp {
    type: number
    sql: ${TABLE}.GDP ;;
  }

  dimension: life_expectancy {
    type: number
    sql: ${TABLE}.lifeExpectancy ;;
  }

  dimension: pollution_index {
    type: number
    sql: ${TABLE}.pollutionIndex ;;
  }

  dimension: sq_meters {
    type: number
    sql: ${TABLE}.sqMeters ;;
  }


 measure: percent_average_humidity {
   type: average
   sql: ${average_humidity} ;;
   value_format_name: percent_1
 }


  measure: count {
    type: count
    drill_fields: []
  }
}
