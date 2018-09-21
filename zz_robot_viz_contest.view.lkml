view: robot_viz_contest {
  sql_table_name: ao_looker_test.robot_viz_contest ;;

  dimension: active_cleaning_duration {
    description: "total time the robot was active excluding time paused and time spend on dock e.g. recharging (seconds)
"
    type: number
    sql: ${TABLE}.active_cleaning_duration ;;
  }

  dimension: cleanid {
    description: "Unique clean identifier"
    type: string
    sql: ${TABLE}.cleanid ;;
  }


  dimension: months_since_first_run {
    view_label: "Robot Facts"
    type: number
    sql: DATE_DIFF( ${utc_date}, ${robot_facts.first_clean_date}, month ) ;;
  }

  dimension: country_code {
    description: "County code - based on serial number allocation"
    type: string
    map_layer_name: countries
    sql: CASE WHEN ${TABLE}.country_code = 'CN' THEN 'CHN'
              WHEN ${TABLE}.country_code = 'CA' THEN 'CAN'
              WHEN ${TABLE}.country_code = 'JP' THEN 'JPN'
              WHEN ${TABLE}.country_code = 'EU' THEN 'DEU'
              WHEN ${TABLE}.country_code = 'UK' THEN 'GBR'
              WHEN ${TABLE}.country_code = 'US' THEN 'USA'
              else ${TABLE}.country_code
              -- WHEN ${TABLE}.country_code = 'XC' THEN 'XXX' -- XC has no ISO3 code - odd that Ceuta in the set?
              end
    ;;
  }




  dimension: country {
    sql: CASE
    WHEN ${country_code} = "USA" THEN "United States"
    WHEN ${country_code} = "CHN" THEN "China"
    WHEN ${country_code} = "DEU" THEN "Germany"
    WHEN ${country_code} = "GBR" THEN "United Kingdom"
    WHEN ${country_code} = "CAN" THEN "Canada"
    WHEN ${country_code} = "JPN" THEN "Japan"
    WHEN ${country_code} = "MYS" THEN "Malaysia"
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


################## FLAGS           ############################################
################## LARGE PNG FLAG  ############################################

  dimension: region_flag_large {
    label: "Region (approx.)"
    type: string
    sql: case when ${country} = 'United Kingdom' then 'United-Kingdom'
              when ${country} = 'United States' then 'United-States'
              when ${country} = 'New Zealand' then 'New Zealand'
              else ${country}
          end;;
    html: <img src="http://icons.iconarchive.com/icons/gosquared/flag/64/{{ value }}-icon.png" /> ;;

    # Adds drill down links to country SAP report.
    link: {
      label: "{{robot_viz_contest.country._value}} SAP report"
      url: "/dashboards/69?Country={{ robot_viz_contest.country._value | encode_uri }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
    }
  }


################## SMALL SVG FLAG  ############################################

# SVGs more performant for the data tables.  We don't need all the region codes here.
  dimension: country_icon {
    type: string
    sql: case when ${country} = 'United Kingdom' then 'gbr'
              when ${country} = 'Germany' then 'deu'
              when ${country} = 'France' then 'fra'
              when ${country} = 'Japan' then 'jpn'
              when ${country} = 'United States' then 'usa'
              when ${country} = 'Canada' then 'can'
              when ${country} = 'Malaysia' then 'mys'
              when ${country} = 'Spain' then 'esp'
              when ${country} = 'Sweden' then 'swe'
              when ${country} = 'Norway' then 'nor'
              when ${country} = 'Denmark' then 'dnk'
              when ${country} = 'Austria' then 'aut'
              when ${country} = 'Australia' then 'aus'
              when ${country} = 'Belguim' then 'bel'
              when ${country} = 'Belgium' then 'bel'
              when ${country} = 'Italy' then 'ita'
              when ${country} = 'Korea' then 'kor'
              when ${country} = 'China' then 'chn'
              when ${country} = 'Switzerland' then 'che'
              when ${country} = 'Russia' then 'rus'
              when ${country} = 'Mexico' then 'mex'
              when ${country} = 'Brazil' then 'bra'
              when ${country} = 'Netherlands' then 'nld'
              when ${country} = 'Poland' then 'pol'
              when ${country} = 'India' then 'ind'
              when ${country} = 'Hong Kong' then 'hkg'
              when ${country} = 'Ireland' then 'irl'
              when ${country} = 'Finland' then 'fin'
              when ${country} = 'Singapore' then 'sgp'
              when ${country} = 'New Zealand' then 'nzl'

 else null
          end;;
    html: <img src="https://restcountries.eu/data/{{ value }}.svg" style="width:50px;height:30px;"/> ;;

    # Adds drill down links to SAP
    link: {
      label: "{{robot_viz_contest.country_value}} SAP report"
      url: "/dashboards/69?Country={{ robot_viz_contest._value | encode_uri }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
    }
  }


#####################  END OF FLAGS  ###############################################################




  dimension: detailed_timings_cleaning {
    description: "total time in seconds when the robot believes it knows its location and is out cleaning"
    type: number
    sql: ${TABLE}.detailed_timings_cleaning ;;
  }

  dimension: detailed_timings_in_emergency {
    description: "total time in seconds"
    type: number
    sql: ${TABLE}.detailed_timings_in_emergency ;;
  }

  dimension: detailed_timings_midclean_charge {
    description: "total time in seconds spent on the dock during a cleaning run (not including time before or after a run)"
    type: number
    sql: ${TABLE}.detailed_timings_midclean_charge ;;
  }

  dimension: detailed_timings_paused {
    description: "total time in seconds where the robot is visibly paused"
    type: number
    sql: ${TABLE}.detailed_timings_paused ;;
  }

  dimension: detailed_timings_returning_to_start {
    description: "total time in seconds when the robot is returning its start location (either to recharge or end the clean)"
    type: number
    sql: ${TABLE}.detailed_timings_returning_to_start ;;
  }

  dimension: detailed_timings_stuck {
    description: "total time in seconds when the robot is trying to free itself from a stuck condition"
    type: number
    sql: ${TABLE}.detailed_timings_stuck ;;
  }

  dimension: detailed_timings_user_recoverable_fault {
    description: "total time in seconds where the robot is waiting on the user to recover it from a 'user-recoverable' fault"
    type: number
    sql: ${TABLE}.detailed_timings_user_recoverable_fault ;;
  }

  dimension: detailed_timings_waiting_to_start {
    description: "total time in seconds between the user telling the robot to start clean and the time it statrs moving"
    type: number
    sql: ${TABLE}.detailed_timings_waiting_to_start ;;
  }

  dimension: emergency_occurrences {
    description: "count of times the robot enters emergency mode"
    type: number
    sql: ${TABLE}.emergency_occurrences ;;
  }

  dimension: end_condition_description {
    description: "detailed End state of the clean"
    type: string
    sql: ${TABLE}.end_condition_description ;;
  }

  dimension: end_condition_group {
    drill_fields: [end_condition_description]
    description: "High level end state of the clean"
    type: string
    sql: ${TABLE}.end_condition_group ;;
  }

  dimension: estimated_coverage_area {
    description: "Coverage area for the clean in m^2 tiles"
    type: number
    sql: ${TABLE}.estimated_coverage_area ;;
  }

  dimension: powermode {
    description: "powermode used for the clean. Mixed implies a change during the course of the clean
"
    type: string
    sql: ${TABLE}.powermode ;;
  }

  dimension: recharge_events {
    description: "number of times the robot recharges on the dock during a clean"
    type: number
    sql: ${TABLE}.recharge_events ;;
  }

  dimension: serial_ref {
    description: "Unique numeric reference to a product (in lieu of a serialnumber – to ensure anonymisation)"
    type: number
    sql: ${TABLE}.serial_ref ;;
  }

  # Seems like they all have the same start location?  Not sure we can do much with this field.
  dimension: start_location {
    description: "where the robot starts its clean (on dock/off dock)"
    type: string
    sql: ${TABLE}.start_location ;;
  }

  dimension_group: utc {
    description: "Start time in UTC"
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      hour,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time_utc ;;
  }

  dimension: startmode {
    description: "Method in which the clean started"
    type: string
    sql: ${TABLE}.startmode ;;
  }

  dimension: stuck_occurrences {
    description: "count of times the robot attempts recovery from physical stuck
"
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
    value_format: "0.00,,\" M m2\""
    group_label: "Custom fields"
    sql: ${estimated_coverage_area} ;;
    html: £{{rendered_value}} ;;
  }


  ######### Custom data-level measures ########

  measure: total_cleans_last_month {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${cleanid} ;;
    filters: {
      field: utc_month
      value: "last month"
    }
  }

  measure: total_cleans_previous_month {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${cleanid} ;;
    filters: {
      field: utc_month
      value: "2 months ago"
    }
  }

  measure: change_in_cleans_lmmth_vs_previousmnth {
    type: number
    group_label: "Custom fields"
    sql: 1.0 * ${total_cleans_last_month} / NULLIF(${total_cleans_previous_month},0) ;;
    value_format_name: percent_1

    html:
      {% if value > 1 %}
      <div style="color: #5f9524; "> ▲ {{ rendered_value }}</div>
      {% else %}
      <div style="color: #dd4157; "> ▼ {{ rendered_value }}</div>
      {% endif %} ;;
  }

  # Used to calculate active machines last month
   measure: number_of_active_machines_last_month {
    type: count_distinct
    group_label: "Custom fields"
    sql: ${serial_ref} ;;
    filters: {
      field: utc_month
      value: "last month"
    }
  }

 measure: percent_of_machines_in_the_wild_active_last_month {
   type: number
   group_label: "Custom fields"
  sql: 1.0 * ${number_of_active_machines_last_month} / NULLIF(${number_of_machines},0) ;;
  value_format_name: percent_1

 }

# Converts seconds foramt to days, hours, minutes and seconds.  Can we get a more human-readable version?
measure: clean_time_days_hours_minutes_seconds {
  label: "Total clean time: dd:hh:mm:ss"
  type: number
  sql:  ${total_cleaning_time} / 86400.0 ;;
  value_format: "dd:hh:mm:ss"
}




  measure: count {
    type: count
    drill_fields: []
  }
}
