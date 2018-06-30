view: weekly_global_stats {
  derived_table: {
    sql_trigger_value: select current_date ;;
    sql: -- France
      SELECT
        FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS TIMESTAMP), DAY), INTERVAL (0 - CAST((CASE WHEN (EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7 < 0 THEN -1 * (ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64))) ELSE ABS((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) - (ABS(7) * CAST(FLOOR(ABS(((EXTRACT(DAYOFWEEK FROM (TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE)))) ) - 1) - 1 + 7) / (7))) AS INT64)) END) AS INT64)) DAY), DAY)) AS ga_sessions_visitstart_week_1,
        ga_sessions.channelGrouping AS ga_sessions_channelgrouping_1,
        device.isMobile AS device_ismobile_1,
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
        device.isMobile AS device_ismobile_1,
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
        device.isMobile AS device_ismobile_1,
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
        device.isMobile AS device_ismobile_1,
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
        device.isMobile AS device_ismobile_1,
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ga_sessions_visitstart_week_1 {
    type: string
    sql: ${TABLE}.ga_sessions_visitstart_week_1 ;;
  }

  dimension: ga_sessions_channelgrouping_1 {
    label: "Channel Grouping"
    type: string
    sql: ${TABLE}.ga_sessions_channelgrouping_1 ;;
  }

  dimension: Is_mobile {
    type: yesno
    sql: ${TABLE}.device_ismobile_1 = true;;
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
    sql: ${TABLE}.ga_sessions_session_count ;;
  }

  dimension: totals_pageviews_total {
    type: number
    sql: ${TABLE}.totals_pageviews_total ;;
  }

  dimension: totals_transactions_count {
    type: number
    sql: ${TABLE}.totals_transactions_count ;;
  }

  dimension: totals_conversion_rate {
    type: number
    sql: ${TABLE}.totals_conversion_rate ;;
  }

  dimension: totals_value_per_session_gbp {
    type: number
    sql: ${TABLE}.totals_value_per_session_gbp ;;
  }

  dimension: totals_average_order_value_gbp {
    type: number
    sql: ${TABLE}.totals_average_order_value_gbp ;;
  }

  measure: average_order_value_gbp {
    type: average
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

  set: detail {
    fields: [
      ga_sessions_visitstart_week_1,
      ga_sessions_channelgrouping_1,
      ga_sessions_website_selector,
      ga_sessions_session_count,
      totals_pageviews_total,
      totals_transactions_count,
      totals_conversion_rate,
      totals_value_per_session_gbp,
      totals_average_order_value_gbp
    ]
  }
}
