view: sap_budget_daily {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql: SELECT
      day as date
                  ,region
                  ,channel
                  ,budgetNetRevenue
                  ,monthly_budgetNetRevenue
        -- *
            FROM UNNEST(
              GENERATE_DATE_ARRAY(DATE('2017-01-01'), DATE('2018-12-31'), INTERVAL 1 DAY)
              ) AS day
            left join (
            -- Get all monthly targets joined with each day in the month from scaffold.
            SELECT dateMonth as date
                  ,budgetRegion as region
                  ,channel
                  ,budgetNetRevenue/DATE_DIFF(DATE_TRUNC(DATE_ADD(dateMonth, INTERVAL 1 MONTH), MONTH), DATE_TRUNC(dateMonth, MONTH), DAY) as budgetNetRevenue
                  ,budgetNetRevenue as monthly_budgetNetRevenue
                  ,'budget' as source
                  ,DATE_DIFF(DATE_TRUNC(DATE_ADD(dateMonth, INTERVAL 1 MONTH), MONTH), DATE_TRUNC(dateMonth, MONTH), DAY) as days_in_month
            FROM `dyson-ga.ao_looker_test.sap_budget` ) e on (FORMAT_TIMESTAMP('%Y-%m', CAST(day  AS TIMESTAMP))) = (FORMAT_TIMESTAMP('%Y-%m', CAST(e.date  AS TIMESTAMP)))
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

  dimension: budget_net_revenue {
    type: number
    sql: ${TABLE}.budgetNetRevenue ;;
  }

  dimension: monthly_budget_net_revenue {
    type: number
    sql: ${TABLE}.monthly_budgetNetRevenue ;;
  }

  set: detail {
    fields: [date, region, channel, budget_net_revenue, monthly_budget_net_revenue]
  }
}
