view: robot_viz_contest {
  sql_table_name: ao_looker_test.robot_viz_contest ;;

# Is there a way to calculate an end-time based on these duration fields and the start-time?
  dimension: active_cleaning_duration {
    type: number
    sql: ${TABLE}.active_cleaning_duration ;;
  }

  dimension: clean_id {
    type: string
    sql: ${TABLE}.cleanid ;;
  }
# https://raw.githubusercontent.com/brechtv/looker_map_layers/master/world-countries.json We can augment this to cover "countries" not in the set.
  dimension: country_code {
    type: string
    map_layer_name: countries
    sql: CASE WHEN ${TABLE}.country_code = 'CN' THEN 'CHN'
              WHEN ${TABLE}.country_code = 'CA' THEN 'CAN'
            --  WHEN ${TABLE}.country_code = 'EU' THEN 'XXX'(EU is not a country)
              WHEN ${TABLE}.country_code = 'JP' THEN 'JPN'
              WHEN ${TABLE}.country_code = 'UK' THEN 'GBR'
              WHEN ${TABLE}.country_code = 'US' THEN 'USA'
              else ${TABLE}.country_code
              -- WHEN ${TABLE}.country_code = 'XC' THEN 'XXX' -- XC has no ISO3 code - odd that Ceuta in the set?
              end
    ;;
  }

  dimension: detailed_timings_cleaning {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_cleaning ;;
  }

  dimension: detailed_timings_in_emergency {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_in_emergency ;;
  }

  dimension: detailed_timings_midclean_charge {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_midclean_charge ;;
  }

  dimension: detailed_timings_paused {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_paused ;;
  }

  dimension: detailed_timings_returning_to_start {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_returning_to_start ;;
  }

  dimension: detailed_timings_stuck {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_stuck ;;
  }

  dimension: detailed_timings_user_recoverable_fault {
    group_label: "Detailed Timings"
    type: number
    sql: ${TABLE}.detailed_timings_user_recoverable_fault ;;
  }

  dimension: detailed_timings_waiting_to_start {
    group_label: "Detailed Timings"
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

  dimension: power_mode {
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

  dimension_group: start {
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

  dimension: start_mode {
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
