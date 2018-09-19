view: robot_viz_contest {
  sql_table_name: ao_looker_test.robot_viz_contest ;;

  dimension: active_cleaning_duration {
    type: number
    sql: ${TABLE}.active_cleaning_duration ;;
  }

  dimension: cleanid {
    type: string
    sql: ${TABLE}.cleanid ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: detailed_timings_cleaning {
    type: number
    sql: ${TABLE}.detailed_timings_cleaning ;;
  }

  dimension: detailed_timings_in_emergency {
    type: number
    sql: ${TABLE}.detailed_timings_in_emergency ;;
  }

  dimension: detailed_timings_midclean_charge {
    type: number
    sql: ${TABLE}.detailed_timings_midclean_charge ;;
  }

  dimension: detailed_timings_paused {
    type: number
    sql: ${TABLE}.detailed_timings_paused ;;
  }

  dimension: detailed_timings_returning_to_start {
    type: number
    sql: ${TABLE}.detailed_timings_returning_to_start ;;
  }

  dimension: detailed_timings_stuck {
    type: number
    sql: ${TABLE}.detailed_timings_stuck ;;
  }

  dimension: detailed_timings_user_recoverable_fault {
    type: number
    sql: ${TABLE}.detailed_timings_user_recoverable_fault ;;
  }

  dimension: detailed_timings_waiting_to_start {
    type: number
    sql: ${TABLE}.detailed_timings_waiting_to_start ;;
  }

  dimension: emergency_occurrences {
    type: number
    sql: ${TABLE}.emergency_occurrences ;;
  }

  dimension: end_condition_description {
    type: string
    sql: ${TABLE}.end_condition_description ;;
  }

  dimension: end_condition_group {
    type: string
    sql: ${TABLE}.end_condition_group ;;
  }

  dimension: estimated_coverage_area {
    type: number
    sql: ${TABLE}.estimated_coverage_area ;;
  }

  dimension: powermode {
    type: string
    sql: ${TABLE}.powermode ;;
  }

  dimension: recharge_events {
    type: number
    sql: ${TABLE}.recharge_events ;;
  }

  dimension: serial_ref {
    type: number
    sql: ${TABLE}.serial_ref ;;
  }

  dimension: start_location {
    type: string
    sql: ${TABLE}.start_location ;;
  }

  dimension_group: start_time_utc {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time_utc ;;
  }

  dimension: startmode {
    type: string
    sql: ${TABLE}.startmode ;;
  }

  dimension: stuck_occurrences {
    type: number
    sql: ${TABLE}.stuck_occurrences ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
