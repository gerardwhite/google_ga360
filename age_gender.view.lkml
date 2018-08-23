view: age_gender {
  sql_table_name: ao_looker_test.Age_Gender ;;

  dimension: age {
    type: string
    sql: ${TABLE}.Age ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.Sessions ;;
  }

  # Sums the sessions
  measure: total_visits  {
    type: sum
    sql: ${sessions} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
