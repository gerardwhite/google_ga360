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

  dimension: country {
    sql: CASE
    WHEN ${country_code} = "US" THEN "United States"
    WHEN ${country_code} = "CN" THEN "China"
    WHEN ${country_code} = "EU" THEN "Germany"
    WHEN ${country_code} = "UK" THEN "United Kingdom"
    WHEN ${country_code} = "CA" THEN "Canada"
    WHEN ${country_code} = "JP" THEN "Japan"
    WHEN ${country_code} = "XC" THEN "Malaysia"
    ELSE ${country_code}
    END
    ;;
  }


  dimension: website {
    type: string
    sql: CASE
                WHEN ${country} = "Canada" THEN "www.dysoncanada.ca"
                WHEN ${country} = "China" THEN "www.dyson.cn"
                WHEN ${country} = "United States" THEN "www.dyson.com"
                WHEN ${country} = "Japan" THEN "www.dyson.co.jp"
                WHEN ${country} = "Malaysia" THEN "www.dyson.kr"
                WHEN ${country} = "United Kingdom" THEN "www.dyson.co.uk"
                WHEN ${country} = "Germany" THEN "www.dyson.de"
                ELSE NULL
            END ;;
  }


# Flags AND drill-down to pre-created SAP reports

  dimension: country_icon_large {
    type: string
    sql: case when ${country} = 'United Kingdom' then 'United-Kingdom'
              when ${country} = 'United States' then 'United-States'
              when ${country} = 'New Zealand' then 'New Zealand'
              else ${country}
          end;;
    html: <img src="http://icons.iconarchive.com/icons/gosquared/flag/64/{{ value }}-icon.png" /> ;;

    # Adds drill down links to country SAP report.
    link: {
      label: "{{sap_all.country._value}} SAP report"
      url: "/dashboards/69?Country={{ sap_all.country._value | encode_uri }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
    }
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

  # Seems like they all have the same start location?  Not sure we can do much with this field.
  dimension: start_location {
    type: string
    sql: ${TABLE}.start_location ;;
  }

  dimension_group: utc {
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
      month_name,
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

  #############   Calculated fields ##########

  measure: number_of_machines {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${serial_ref} ;;
  }

  measure: number_of_cleans {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${cleanid} ;;
  }

  measure: average_cleans_per_machine {
    type: number
    group_label: "Custom fields"
    sql: ${number_of_cleans}/${number_of_machines} ;;
    value_format_name: decimal_2
  }


  # Can we convert this seconds number to hours and days?
  measure: total_cleaning_time {
    type: sum
    group_label: "Custom fields"
    sql: ${active_cleaning_duration} ;;
  }

  measure: total_cleaning_area {
    type: sum
    group_label: "Custom fields"
    sql: ${estimated_coverage_area} ;;

  }


  ######### Custom data-level measures ########

  measure: cleans_last_month {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${cleanid} ;;
    filters: {
      field: utc_month
      value: "last month"
    }
  }

  measure: cleans_previous_month {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${cleanid} ;;
    filters: {
      field: utc_month
      value: "2 months ago"
    }
  }




  measure: count {
    type: count
    drill_fields: []
  }
}
