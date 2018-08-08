# Alternative apprach in modelling SAP Data given we have one date series
# This approach eliminates the need for multiple joins, although increases the raw SQL
# we need.

view: sap_all {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql: SELECT  date
        ,region
        ,channel
        ,sales
        ,orders
        ,null as revenue6plus
        ,null as budgetNetRevenue
        ,'SAP Actual' as source
FROM `dyson-ga.ao_looker_test.SAP`

UNION ALL

 SELECT date as date
      ,region
      ,channel
      ,null as sales
      ,null as orders
      ,revenue6plus -- this number is DAILY for each country and channel
      ,null as budgetNetRevenue
      ,'6plus6' as source
FROM  ${sap_6plus6_daily.SQL_TABLE_NAME} --the calculated daily values

UNION ALL

SELECT dateMonth as date
      ,budgetRegion as region
      ,channel
      ,null as sales
      ,null as orders
      ,null as revenue6plus
      ,budgetNetRevenue
      ,'budget' as source
FROM `dyson-ga.ao_looker_test.sap_budget`
 ;;
  }


# Main and ONLY date column we have in this data set
# Currently using month for reports works as targets are set on monthly basis.
# todo: divide this into days
  dimension_group: date {
    type: time
    timeframes: [year, month, quarter, date, week, week_of_year]
    sql: ${TABLE}.date ;;
    convert_tz: no
    datatype: date
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: days_in_month {
    type: number
    sql:  ${TABLE}.days_in_month;;
  }



  dimension: channel {
      type: string
#     Transforming as 6plus6 data requires a clean
      sql: CASE WHEN ${TABLE}.channel = "Direct_OnlineStores - Dyson Online Stores" THEN "Dyson Online Store"
            WHEN ${TABLE}.channel = "Direct_Marketplaces - Dyson MarketPlaces" THEN "Dyson Marketplaces"
            WHEN ${TABLE}.channel = "Direct_SalesService - Dyson Sales & Service" THEN "Dyson Sales & Service"
            WHEN ${TABLE}.channel = "Direct_RetailStores - Dyson Retail Stores" THEN "Dyson Retail Stores"
            ELSE ${TABLE}.channel
            END ;;
    link: {
      label: "{{sap_all.channel._value}} report"
      url: "https://dysonuk.eu.looker.com/dashboards/26?Region=www.dyson.fr"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/GA2.png"
    }

  }

#   Includes transforms for different data sets.
#   This could probably be more modular but fine for now.
  dimension: country {
    type: string
    sql: CASE
                --Actual
                WHEN ${region} = "Dyson FR" THEN "France"
                WHEN ${region} = "Dyson BE" THEN "Belguim"
                WHEN ${region} = "Dyson AT" THEN "Austria"
                WHEN ${region} = "Dyson AU" THEN "Australia"
                WHEN ${region} = "Dyson CA" THEN "Canada"
                WHEN ${region} = "Dyson CN" THEN "China"
                WHEN ${region} = "Dyson TBL" THEN "China"
                WHEN ${region} = "Dyson AT" THEN "Austria"
                WHEN ${region} = "Dyson Direct" THEN "United States"
                WHEN ${region} = "Dyson DK" THEN "Denmark"
                WHEN ${region} = "Dyson ES" THEN "Spain"
                WHEN ${region} = "Dyson CA" THEN "Canada"
                WHEN ${region} = "Dyson FI" THEN "Finland"
                WHEN ${region} = "Dyson IE" THEN "Ireland"
                WHEN ${region} = "Dyson IE (NI)" THEN "Ireland"
                WHEN ${region} = "Dyson IN" THEN "India"
                WHEN ${region} = "Dyson IT" THEN "Italy"
                WHEN ${region} = "Dyson JP" THEN "Japan"
                WHEN ${region} = "Dyson KR" THEN "Korea"
                WHEN ${region} = "Dyson MX" THEN "Mexico"
                WHEN ${region} = "Dyson NL" THEN "Netherlands"
                WHEN ${region} = "Dyson UK" THEN "United Kingdom"
                WHEN ${region} = "Dyson NO" THEN "Norway"
                WHEN ${region} = "Dyson SE" THEN "Sweden"
                WHEN ${region} = "Dyson CH" THEN "Switzerland"
                WHEN ${region} = "Dyson GCP Hangzhou" THEN "China"
                WHEN ${region} = "Dyson DE" THEN "Germany"
                WHEN ${region} = "Dyson SG" THEN "Singapore"

                --6plus6
                WHEN ${region} = "10 - Great Britain" THEN "United Kingdom"
                WHEN ${region} = "30 - USA " THEN "United States"
                WHEN ${region} = "41 - Mexico" THEN "Mexico"
                WHEN ${region} = "45 - Canada " THEN "Canada"
                WHEN ${region} = "50 - Ireland " THEN "Ireland"
                WHEN ${region} = "51 - Germany " THEN "Germany"
                WHEN ${region} = "52 - Austria " THEN "Austria"
                WHEN ${region} = "53 - France " THEN "France"
                WHEN ${region} = "55 - Spain " THEN "Spain"
                WHEN ${region} = "56 - Switzerland " THEN "Switzerland"
                WHEN ${region} = "58 - Belgium " THEN "Belguim"
                WHEN ${region} = "85 - India" THEN "India"
                WHEN ${region} = "88 - China - Beijing" THEN "China"
                WHEN ${region} = "57 - Netherlands" THEN "Netherlands"
                WHEN ${region} = "92 - Australia " THEN "Australia"
                WHEN ${region} = "63 - Russia " THEN "Russia"
                WHEN ${region} = "61 - Sweden " THEN "Sweden"
                WHEN ${region} = "59 - Denmark Sub " THEN "Denmark"
                WHEN ${region} = "90 - Japan " THEN "Japan"
                WHEN ${region} = "64 - Finland Sub" THEN "Finland"
                WHEN ${region} = "86 - Korea" THEN "Korea"
                WHEN ${region} = "60 - Norway " THEN "Norway"
                WHEN ${region} = "62 - Italy " THEN "Italy"
                WHEN ${region} = "8A - China - Hangzhou" THEN "China"
                WHEN ${region} = "67 - Poland" THEN "Poland"
                WHEN ${region} = "91 - Singapore " THEN "Singapore"
                WHEN ${region} = "89 - China - Shanghai" THEN "China"
                WHEN ${region} = "60 - Norway " THEN "Norway"
                WHEN ${region} = "9A - New Zealand" THEN "New Zealand"
                WHEN ${region} = "9A - New Zealand " THEN "New Zealand"

                --Budget
                WHEN ${region} = "USA" THEN "United States"
                ELSE ${region}
            END ;;


      link: {
        label: "{{sap_all.country._value}} SAP report"
        url: "/dashboards/55?Country={{ sap_all.country._value | encode_uri }}"
        icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
      }
    }


  dimension: country_icon {
    type: string
    sql: case when ${country} = 'United Kingdom' then 'gbr'
              when ${country} = 'Germany' then 'deu'
              when ${country} = 'France' then 'fra'
              when ${country} = 'Japan' then 'jpn'
              when ${country} = 'United States' then 'usa'
              when ${country} = 'Canada' then 'can'
              when ${country} = 'Spain' then 'esp'
              when ${country} = 'Sweden' then 'swe'
              when ${country} = 'Norway' then 'nor'
              when ${country} = 'Denmark' then 'dnk'
              when ${country} = 'Austria' then 'aut'
              when ${country} = 'Australia' then 'aus'
              when ${country} = 'Belguim' then 'bel'
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

 else null
          end;;
    html: <img src="https://restcountries.eu/data/{{ value }}.svg" style="width:50px;height:30px;"/> ;;

#     # Adds drill down links to country maps.  Label needs to change for link to work.
#     link: {
#       label: "{{sap.country._value}} SAP report"
#       url: "/dashboards/55?Country={{ sap.country._value | encode_uri }}"
#       icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
#     }
  }


  dimension: country_rank {
    type: number
    sql: case when ${country} = 'China' then 1
              when ${country} = 'United States' then 2
              when ${country} = 'United Kingdom' then 3
              when ${country} = 'Japan' then 4
              when ${country} = 'Germany' then 5
              when ${country} = 'France' then 6
              when ${country} = 'Canada' then 7
              when ${country} = 'Australia' then 8
              when ${country} = 'Italy' then 9
              when ${country} = 'Spain' then 10
              when ${country} = 'Switzerland' then 11
              when ${country} = 'Netherlands' then 12
              when ${country} = 'Austria' then 13
              when ${country} = 'Ireland' then 14
              when ${country} = 'India' then 15
              when ${country} = 'Belguim' then 16
              when ${country} = 'Denmark' then 17
              when ${country} = 'Korea' then 18
              when ${country} = 'Singapore' then 19
              when ${country} = 'Sweden' then 20
              when ${country} = 'Norway' then 21
              when ${country} = 'Finland' then 22
              when ${country} = 'Mexico' then 23

 else 100
          end;;
  }



# Dimensions

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: orders {
    type: number
    sql: ${TABLE}.orders ;;
  }

  dimension: revenue6plus {
    type: number
    sql: ${TABLE}.revenue6plus ;;
  }

  dimension: budget_net_revenue {
    type: number
    sql: ${TABLE}.budgetNetRevenue ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }



#   ACTUALS

  measure: total_revenue {
    label: "Total Revenue"
    type: sum
    value_format_name: gbp_0
    sql: ${sales} ;;
    filters: {
      field: source
      value: "SAP Actual"
    }
  }


  measure: total_orders {
    type: sum
    sql: ${orders} ;;
    filters: {
      field: source
      value: "SAP Actual"
    }
  }

#Calculated ranges for last week
  measure: revenue_last_week {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_week
      value: "last week"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
  }

  measure: revenue_previous_week {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_week
      value: "2 weeks ago"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
  }


  measure: revenue_last_week_last_year {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_week
      value: "53 weeks ago"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
  }


  measure: lw_change_on_lw_last_year{
    label: "LW % change on revenue LWLY"
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${revenue_last_week}-${revenue_last_week_last_year})/NULLIF(${revenue_last_week_last_year},0))  ;;
    value_format_name: percent_1
  }

  measure: revenue_this_quarter {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "this quarter"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
  }


  measure: revenue_this_month {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "this month"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }


  measure: revenue_last_month {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "last month"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }

  measure: revenue_previous_month {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "2 months ago"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
  }


  measure: revenue_this_month_last_year {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "13 months ago"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }


  measure: revenue_last_month_last_year {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "13 months ago"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }



  measure: revenue_this_year {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "this year"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }

  measure: revenue_last_year {
    type: sum
    value_format: "0.0,,\" M\""
    group_label: "Custom SAP measures"
    sql: ${sales} ;;
    filters: {
      field: date_month
      value: "last year"
    }
    filters: {
      field: source
      value: "SAP Actual"
    }
    html: £{{rendered_value}} ;;
  }

  measure: revenue_change_on_last_year{
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${revenue_this_year}-${revenue_last_year})/NULLIF(${revenue_last_year},0))  ;;
    value_format_name: percent_2
  }







#   6plus6

  measure: revenue_forcast_LE{
    label: "LE 6+6 target"
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${revenue6plus} ;;
    filters: {
      field: source
      value: "6plus6"
    }
    html: £{{rendered_value}} ;;
  }


  measure: revneue_forcast_this_month {
    label: "LE 6+6 target this month"
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${revenue6plus};;
    filters: {
      field: date_date
      value: "this month"
    }
    filters: {
      field: source
      value: "6plus6"
    }
    html: £{{rendered_value}} ;;
  }





  measure: le_revenue_this_year {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${revenue6plus} ;;
    filters: {
      field: date_date
      value: "this year"
    }
    filters: {
      field: source
      value: "6plus6"
    }
  }

  measure: le_revenue_last_year {
    type: sum
    value_format_name: gbp_0
    group_label: "Custom SAP measures"
    sql: ${revenue6plus} ;;
    filters: {
      field: date_date
      value: "last year"
    }
    filters: {
      field: source
      value: "6plus6"
    }
  }




#   Budget


  measure: budget_revenue_2018 {
    type: sum
    value_format_name: gbp_0
    sql: ${budget_net_revenue} ;;
    filters: {
      field: source
      value: "budget"
    }

  }

# Divides monthly budget by days in the month
#   measure: daily_budget_rate {
#     type:  number
#     value_format_name: gbp_0
#     sql:  ${budget_revenue_this_month}/31;;
#   }


  measure: budget_revenue_this_month {
    type: sum
    value_format_name: gbp_0
    sql: ${budget_net_revenue};;
    filters: {
      field: date_date
      value: "this month"
    }
    filters: {
      field: source
      value: "budget"
    }
  }


###############  Comparison Measures #########################

  measure: percent_of_target {
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${total_revenue})/NULLIF(${revenue_forcast_LE},0))  ;;
    value_format_name: percent_1
  }

  measure: percent_of_target_this_month {
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${revenue_this_month})/NULLIF(${revneue_forcast_this_month},0))  ;;
    value_format_name: percent_1
  }

  measure: yoy_growth_target {
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${revenue_forcast_LE}-${revenue_last_year})/NULLIF(${revenue_last_year},0))  ;;
    value_format_name: percent_1
  }

###############  Comparison Formatting  #########################

# Test conditional formating metric on % of monthly forcast achieved:

  measure: percent_of_target_this_month_rg {
    group_label: "Custom SAP measures"
    type: number
    sql: 1.0 * ((${revenue_this_month})/NULLIF(${revneue_forcast_this_month},0))  ;;
    value_format_name: percent_1
    html:
    {% if value <= 0.1 %}
    <div style="color: white; background-color: darkred; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% elsif value <= 0.2 %}
    <div style="color: black; background-color: goldenrod; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% else %}
    <div style="color: white; background-color: darkgreen; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% endif %} ;;



  }






# Other
  set: detail {
    fields: [
      date_date,
      region,
      channel,
      sales,
      orders,
      revenue6plus,
      budget_net_revenue,
      source
    ]
  }
}
