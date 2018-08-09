# GW: This view calculates daily 6plus6 numbers.
# Use this as an Explore to check daily numbers are correct
#  it is used in the sap_all SQL (keeps the SQL readable/managable)


view: sap_6plus6_daily {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql: SELECT day as date
            ,region
            ,channel
            ,revenue6plus
            ,monthly_revenue6plus

      FROM UNNEST(
        GENERATE_DATE_ARRAY(DATE('2017-01-01'), DATE('2018-12-31'), INTERVAL 1 DAY)
        ) AS day
      left join (
      -- Get all monthly targets joined with each day in the month from scaffold.
      SELECT monthDate as date
            ,region
            ,channel
            ,revenue6plus/DATE_DIFF(DATE_TRUNC(DATE_ADD(monthDate, INTERVAL 1 MONTH), MONTH), DATE_TRUNC(monthDate, MONTH), DAY) as revenue6plus
            ,revenue6plus as monthly_revenue6plus
           FROM `dyson-ga.ao_looker_test.sap_6plus6` ) e on (FORMAT_TIMESTAMP('%Y-%m', CAST(day  AS TIMESTAMP))) = (FORMAT_TIMESTAMP('%Y-%m', CAST(e.date  AS TIMESTAMP)))
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: revenue6plus {
    type: number
    sql: ${TABLE}.revenue6plus ;;
  }

  dimension: monthly_revenue6plus {
    type: number
    sql: ${TABLE}.revenue6plus ;;
  }

  set: detail {
    fields: [date, region, channel, revenue6plus, monthly_revenue6plus]
  }
}
