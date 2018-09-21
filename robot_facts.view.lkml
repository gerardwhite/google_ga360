view: robot_facts {
  derived_table: {
    datagroup_trigger:bqml_datagroup
    sql: SELECT serial_ref
       ,min(start_time_utc) as first_clean
       ,max(start_time_utc) as most_recent_clean
FROM `dyson-ga.ao_looker_test.robot_viz_contest`
group by serial_ref
 ;;
  }



  dimension: serial_ref {
    hidden: yes
    type: number
    sql: ${TABLE}.serial_ref ;;
  }


  dimension_group: first_clean {
    timeframes: [week, month, raw, date]
    type: time
    sql: ${TABLE}.first_clean ;;
  }

  dimension_group: most_recent_clean {
    timeframes: [week, month, raw, date]
    type: time
    sql: ${TABLE}.most_recent_clean ;;
  }


}
