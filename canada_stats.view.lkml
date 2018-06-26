view: canada_stats {
  derived_table: {
#     sql_trigger_value: select current_date ;;
    sql: SELECT
        CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS DATE) AS ga_sessions_visitstart_date_1,
        COALESCE(SUM(totals.bounces ), 0) AS totals_bounces_total,
        COALESCE(SUM(totals.hits ), 0) AS totals_hits_total,
        COUNT(CASE WHEN (ga_sessions.visitnumber <> 1) THEN 1 ELSE NULL END) AS ga_sessions_returning_visitors
      FROM
                         `dyson-ga.19209080.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals

      WHERE
        (((TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -30 DAY))) AND (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -30 DAY), INTERVAL 30 DAY)))))
      GROUP BY 1
      ORDER BY 1 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ga_sessions_visitstart_date_1 {
    type: date
    sql: ${TABLE}.ga_sessions_visitstart_date_1 ;;
  }

  dimension: totals_bounces_total {
    type: number
    sql: ${TABLE}.totals_bounces_total ;;
  }

  dimension: totals_hits_total {
    type: number
    sql: ${TABLE}.totals_hits_total ;;
  }

  dimension: ga_sessions_returning_visitors {
    type: number
    sql: ${TABLE}.ga_sessions_returning_visitors ;;
  }

  set: detail {
    fields: [ga_sessions_visitstart_date_1, totals_bounces_total, totals_hits_total, ga_sessions_returning_visitors]
  }
}
