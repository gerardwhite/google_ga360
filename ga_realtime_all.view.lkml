# Only joins US + UK Google Analytics realtime data.  Needs editing for all datasets. PREFIX NOT WORKING SO NEED TO UPDATE FOR DAY's DATA


view: ga_realtime_all {
  derived_table: {
    datagroup_trigger: realtime_datagroup
    sql: SELECT  date
        ,geoNetwork.country as country
        ,trafficSource.campaign as campaign
        -- mask out keyword for faster performance:, trafficSource.keyword as keyword
        ,device.deviceCategory as device
        ,trafficSource.medium as medium
        ,h.hour as hour
        ,h.minute as minute
        ,totals.visits as visits
        ,'www.dyson.co.uk' as website
FROM `dyson-ga.15753450.ga_realtime_sessions_20180912`, UNNEST(hits) as h  -- UK table

UNION ALL

SELECT  date
        ,geoNetwork.country as country
        ,trafficSource.campaign as campaign
        -- mask out keyword for faster performance: ,trafficSource.keyword as keyword
        ,device.deviceCategory as device
        ,trafficSource.medium as medium
        ,h.hour as hour
        ,h.minute as minute
        ,totals.visits as visits
        ,'www.dyson.com' as website
FROM `dyson-ga.15753478.ga_realtime_sessions_20180912`, UNNEST(hits) as h  -- UK table
 ;;
  }

  dimension_group: date {
    type: time
    timeframes: [year, month, quarter, date, week, week_of_year, day_of_week, day_of_month, month_name]
    sql: ${TABLE}.date ;;
    convert_tz: no
    datatype: date
  }


  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  # dimension: keyword {
  #   type: string
  #   sql: ${TABLE}.keyword ;;
  # }

  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: minute {
    type: number
    sql: ${TABLE}.minute ;;
  }

  dimension: visits {
    hidden: yes
    type: number
    sql: ${TABLE}.visits ;;
  }


  measure: total_visits {
    type: sum
    sql: ${TABLE}.visits ;;
  }



  measure: count {
    type: count
    drill_fields: [device]
  }
}
