view: revenue_targets_by_region_2018 {
  sql_table_name: ao_looker_test.revenue_targets_by_region_2018 ;;


  dimension_group: daydate {
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
    sql: ${TABLE}.daydate ;;
  }

  dimension: regioncode {
    type: string
    sql: ${TABLE}.regioncode ;;
  }

  dimension: target_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.target ;;
  }

  measure: target {
    sql: ${target_dim};;
    type: sum
    drill_fields: []
  }
}
