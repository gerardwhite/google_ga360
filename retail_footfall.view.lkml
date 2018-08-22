view: footfall {
  sql_table_name: ao_looker_test.Footfall ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

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
    sql: ${TABLE}.Date ;;
  }

  dimension: footfall {
    type: number
    sql: ${TABLE}.Footfall ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  dimension: store_type {
    type: string
    sql: ${TABLE}.Store_Type ;;
  }

measure: total_footfall  {
  type: sum
  sql: ${footfall} ;;
}


  measure: count {
    type: count
    drill_fields: []
  }
}
