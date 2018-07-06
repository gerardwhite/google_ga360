view: weekly_global_stats {
  view_label: "Dyson Global"
  derived_table: {
    sql_trigger_value: select current_date ;;
    sql: -- France
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
  device.deviceCategory AS device_devicecategory_1,
        'www.dyson.fr'  AS ga_sessions_website_selector,
        COUNT(*) AS ga_sessions_session_count,
        COALESCE(SUM(totals.pageviews ), 0) AS totals_pageviews_total,
        COALESCE(SUM(totals.transactions ), 0) AS totals_transactions_count,
        (COALESCE(SUM(totals.transactions ), 0))/(COUNT(*))   AS totals_conversion_rate,
        (COALESCE(SUM((totals.transactionRevenue/1000000) / tax_xrates_by_country_2018_v2.xrate ), 0)) / (COUNT(*))  AS totals_value_per_session_gbp,
        AVG((totals.transactionRevenue/1000000)/tax_xrates_by_country_2018_v2.xrate ) AS totals_average_order_value_gbp
      FROM
         `dyson-ga.15753748.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN ao_looker_test.tax_xrates_by_country_2018_v2  AS tax_xrates_by_country_2018_v2 ON 'www.dyson.fr' = tax_xrates_by_country_2018_v2.website

      WHERE
        (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))   >= TIMESTAMP('2017-01-01 15:26:00'))
      GROUP BY 1,2,3,4

      UNION ALL

      --UK
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
  device.deviceCategory AS device_devicecategory_1,
        'www.dyson.co.uk'  AS ga_sessions_website_selector,
        COUNT(*) AS ga_sessions_session_count,
        COALESCE(SUM(totals.pageviews ), 0) AS totals_pageviews_total,
        COALESCE(SUM(totals.transactions ), 0) AS totals_transactions_count,
        (COALESCE(SUM(totals.transactions ), 0))/(COUNT(*))   AS totals_conversion_rate,
        (COALESCE(SUM((totals.transactionRevenue/1000000) / tax_xrates_by_country_2018_v2.xrate ), 0)) / (COUNT(*))  AS totals_value_per_session_gbp,
        AVG((totals.transactionRevenue/1000000)/tax_xrates_by_country_2018_v2.xrate ) AS totals_average_order_value_gbp
      FROM
         `dyson-ga.15753450.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN ao_looker_test.tax_xrates_by_country_2018_v2  AS tax_xrates_by_country_2018_v2 ON 'www.dyson.co.uk' = tax_xrates_by_country_2018_v2.website

      WHERE
        (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))   >= TIMESTAMP('2017-01-01 15:26:00'))
      GROUP BY 1,2,3,4

      UNION ALL

      --DE
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
  device.deviceCategory AS device_devicecategory_1,
        'www.dyson.de'  AS ga_sessions_website_selector,
        COUNT(*) AS ga_sessions_session_count,
        COALESCE(SUM(totals.pageviews ), 0) AS totals_pageviews_total,
        COALESCE(SUM(totals.transactions ), 0) AS totals_transactions_count,
        (COALESCE(SUM(totals.transactions ), 0))/(COUNT(*))   AS totals_conversion_rate,
        (COALESCE(SUM((totals.transactionRevenue/1000000) / tax_xrates_by_country_2018_v2.xrate ), 0)) / (COUNT(*))  AS totals_value_per_session_gbp,
        AVG((totals.transactionRevenue/1000000)/tax_xrates_by_country_2018_v2.xrate ) AS totals_average_order_value_gbp
      FROM
         `dyson-ga.60583535.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN ao_looker_test.tax_xrates_by_country_2018_v2  AS tax_xrates_by_country_2018_v2 ON 'www.dyson.de' = tax_xrates_by_country_2018_v2.website

      WHERE
        (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))   >= TIMESTAMP('2017-01-01 15:26:00'))
      GROUP BY 1,2,3,4

      UNION ALL

      --JP
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
  device.deviceCategory AS device_devicecategory_1,
        'www.dyson.co.jp'  AS ga_sessions_website_selector,
        COUNT(*) AS ga_sessions_session_count,
        COALESCE(SUM(totals.pageviews ), 0) AS totals_pageviews_total,
        COALESCE(SUM(totals.transactions ), 0) AS totals_transactions_count,
        (COALESCE(SUM(totals.transactions ), 0))/(COUNT(*))   AS totals_conversion_rate,
        (COALESCE(SUM((totals.transactionRevenue/1000000) / tax_xrates_by_country_2018_v2.xrate ), 0)) / (COUNT(*))  AS totals_value_per_session_gbp,
        AVG((totals.transactionRevenue/1000000)/tax_xrates_by_country_2018_v2.xrate ) AS totals_average_order_value_gbp
      FROM
         `dyson-ga.15754005.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN ao_looker_test.tax_xrates_by_country_2018_v2  AS tax_xrates_by_country_2018_v2 ON 'www.dyson.co.jp' = tax_xrates_by_country_2018_v2.website

      WHERE
        (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))   >= TIMESTAMP('2017-01-01 15:26:00'))
      GROUP BY 1,2,3,4

      UNION ALL
      --COM
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
  device.deviceCategory AS device_devicecategory_1,
        'www.dyson.com'  AS ga_sessions_website_selector,
        COUNT(*) AS ga_sessions_session_count,
        COALESCE(SUM(totals.pageviews ), 0) AS totals_pageviews_total,
        COALESCE(SUM(totals.transactions ), 0) AS totals_transactions_count,
        (COALESCE(SUM(totals.transactions ), 0))/(COUNT(*))   AS totals_conversion_rate,
        (COALESCE(SUM((totals.transactionRevenue/1000000) / tax_xrates_by_country_2018_v2.xrate ), 0)) / (COUNT(*))  AS totals_value_per_session_gbp,
        AVG((totals.transactionRevenue/1000000)/tax_xrates_by_country_2018_v2.xrate ) AS totals_average_order_value_gbp
      FROM
         `dyson-ga.15753478.ga_sessions_*`



                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN ao_looker_test.tax_xrates_by_country_2018_v2  AS tax_xrates_by_country_2018_v2 ON 'www.dyson.com' = tax_xrates_by_country_2018_v2.website

      WHERE
        (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))   >= TIMESTAMP('2017-01-01 15:26:00'))
      GROUP BY 1,2,3,4
       ;;
  }



  dimension_group: start {
    type: time
    timeframes: [week, month, year]
    sql: PARSE_DATE('%Y-%m-%d', ${TABLE}.ga_sessions_visitstart_week_1 );;

  }

#   dimension: start_date {
#         type: string
#      sql: ${TABLE}.ga_sessions_visitstart_week_1 ;;
#     }

#   dimension: reporting_year {
#     group_label: "Order Date"
#     sql: CASE
#         WHEN extract(year from ${start_week}) = extract( year from current_date())
#         AND ${start_week} < CURRENT_DATE()
#         THEN 'This Year to Date'
#
#         WHEN extract(year from ${start_week}) + 1 = extract(year from current_date())
#         AND extract(dayofyear from ${start_week}) <= extract(dayofyear from current_date())
#         THEN 'Last Year to Date'
#
#       END
#        ;;
#   }


  dimension: ga_sessions_channelgrouping_1 {
    label: "Channel Grouping"
    type: string
    sql: ${TABLE}.ga_sessions_channelgrouping_1 ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.device_devicecategory_1 ;;
  }

  dimension: ga_sessions_website_selector {
    label: "GA Property"
    type: string
    sql: ${TABLE}.ga_sessions_website_selector ;;

    link: {
      label: "{{tax_xrates_by_country_2018_v2.country_and_icon._value}} Dashboard"
      url: "/dashboards/8?Property={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }

  }

  dimension: ga_sessions_session_count {
    type: number
    hidden: yes
    sql: ${TABLE}.ga_sessions_session_count ;;
  }

  dimension: totals_pageviews_total {
    type: number
    hidden: yes
    sql: ${TABLE}.totals_pageviews_total ;;
  }

  dimension: totals_transactions_count {
    type: number
    hidden: yes
    sql: ${TABLE}.totals_transactions_count ;;
  }

  dimension: totals_conversion_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.totals_conversion_rate ;;
  }

  dimension: totals_value_per_session_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.totals_value_per_session_gbp ;;
  }

  dimension: totals_average_order_value_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.totals_average_order_value_gbp ;;
  }

  measure: average_order_value_gbp {
    type: average
    value_format_name: gbp
    sql: ${totals_average_order_value_gbp} ;;
  }

  measure:  number_of_transactions{
    type: sum
    sql: ${totals_transactions_count} ;;
  }

  measure:  number_of_sessions{
    type: sum
    sql: ${ga_sessions_session_count} ;;
  }

  measure:  number_of_pageviews{
    type: sum
    sql: ${totals_pageviews_total} ;;
  }

  measure: average_conversion_rate {
    type: average
    sql: ${totals_conversion_rate} ;;
    value_format_name: percent_2
  }

  measure: average_value_per_session {
    type:  average
    sql: ${totals_value_per_session_gbp} ;;
    value_format_name: gbp
  }

  dimension: days_elapsed_2018 {
    type: number
    label: "Days lapsed in 2018"
    sql:  date_diff(current_date(), date(2018,01,01), day)  ;;
  }

  measure: percent_through_2018 {
    type: average
    label: "Percent through 2018"
    sql:  ${days_elapsed_2018}/365  ;;
    value_format_name: percent_2
  }



  set: detail {
    fields: [
      ga_sessions_channelgrouping_1,
      days_elapsed_2018,
      percent_through_2018,
      ga_sessions_session_count,
      totals_pageviews_total,
      totals_transactions_count,
      totals_conversion_rate,
      totals_value_per_session_gbp,
      totals_average_order_value_gbp
    ]
  }
}
