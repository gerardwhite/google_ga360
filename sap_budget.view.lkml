view: sap_budget {
  sql_table_name: ao_looker_test.sap_budget ;;

  dimension: budget_net_revenue {
    type: number
    sql: ${TABLE}.budgetNetRevenue ;;
  }

  dimension: budget_region {
    type: string
    sql: ${TABLE}.budgetRegion ;;
  }



  dimension: country {
    type: string
    sql: CASE WHEN ${budget_region} = "USA" THEN "United States"
                ELSE ${budget_region}
            END ;;

      link: {
        label: "{{sap_budget.country._value}} SAP report"
        url: "/dashboards/55?Country={{ sap_budget.country._value | encode_uri }}"
        icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
      }
    }

    dimension: channel {
      type: string
      sql: ${TABLE}.Channel ;;
    }

    dimension_group: month {
      type: time
      timeframes: [
        raw,
        date,
        day_of_month,
        week,
        week_of_year,
        day_of_week,
        day_of_year,
        month,
        month_name,
        month_num,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.dateMonth ;;
    }




#Custom measures
    measure: budget_revenue_2018 {
      type: sum
      value_format_name: gbp_0
      sql: ${budget_net_revenue} ;;
    }

# Divides monthly budget by days in the month
    measure: daily_budget_rate {
      type:  number
      value_format_name: gbp_0
      sql:  ${budget_revenue_this_month}/31;;
    }


    measure: budget_revenue_this_month {
      type: sum
      value_format_name: gbp_0
      sql: ${budget_net_revenue};;
      filters: {
        field: month_date
        value: "this month"
      }
    }

    dimension: days_in_the_month {
      sql:  DATE_DIFF(DATE_TRUNC(DATE_ADD(${month_date}, INTERVAL 1 MONTH), MONTH),
        DATE_TRUNC(${month_date}, MONTH), DAY) ;;
    }


    measure: count {
      type: count
      drill_fields: []
    }
  }
