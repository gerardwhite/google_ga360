view: sap {
  sql_table_name: ao_looker_test.SAP ;;


# Need to update channel link to be dynamic for region
  dimension: channel {
    type: string
    sql: ${TABLE}.Channel ;;

#     link: {
#       label: "{{sap.channel._value}} report"
#       url: "/dashboards/26?Region={{ sap.website._value | encode_uri }}"
#       icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/GA2.png"
#     }

    link: {
      label: "{{sap.channel._value}} report"
      url: "https://dysonuk.eu.looker.com/dashboards/26?Region=www.dyson.fr"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/GA2.png"
    }



  }



  # Assigns website to SAP region
  dimension: website {
    type: string
    sql: CASE WHEN ${region} = "Dyson FR" THEN "www.dyson.fr"
                WHEN ${region} = "Dyson BE" THEN "www.dyson.be"
                WHEN ${region} = "Dyson AT" THEN "www.dyson.at"
                WHEN ${region} = "Dyson AU" THEN "www.dyson.com.au"
                WHEN ${region} = "Dyson CA" THEN "www.dysoncanada.ca"
                WHEN ${region} = "Dyson CN" THEN "www.dyson.cn"
                WHEN ${region} = "Dyson TBL" THEN "www.dyson.cn"
                WHEN ${region} = "Dyson Direct" THEN "www.dyson.com"
                WHEN ${region} = "Dyson DK" THEN "www.dyson.dk"
                WHEN ${region} = "Dyson ES" THEN "www.dyson.es"
                WHEN ${region} = "Dyson FI" THEN "www.dyson.fi"
                WHEN ${region} = "Dyson IE" THEN "www.dyson.ie"
                WHEN ${region} = "Dyson IE (NI)" THEN "www.dyson.ie"
                WHEN ${region} = "Dyson IN" THEN "www.dyson.in"
                WHEN ${region} = "Dyson IT" THEN "www.dyson.it"
                WHEN ${region} = "Dyson JP" THEN "www.dyson.co.jp"
                WHEN ${region} = "Dyson KR" THEN "www.dyson.kr"
                WHEN ${region} = "Dyson MX" THEN "www.dyson.mx"
                WHEN ${region} = "Dyson NL" THEN "www.dyson.nl"
                WHEN ${region} = "Dyson UK" THEN "www.dyson.co.uk"
                WHEN ${region} = "Dyson NO" THEN "www.dyson.no"
                WHEN ${region} = "Dyson SE" THEN "www.dyson.se"
                WHEN ${region} = "Dyson CH" THEN "www.dyson.ch"
                WHEN ${region} = "Dyson GCP Hangzhou" THEN "www.dyson.cn"
                WHEN ${region} = "Dyson DE" THEN "www.dyson.de"
                ELSE NULL
            END ;;


      link: {
        label: "{{sap.country._value}} SAP report"
        url: "/dashboards/55?Country={{ sap.country._value | encode_uri }}"
        icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
      }
    }





    dimension: concat {
      hidden: yes
      type: string
      sql: ${TABLE}.Concat ;;
    }

    dimension_group: date {
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
      sql: ${TABLE}.Date ;;
    }

#Is before month to date
    dimension: is_before_MTD {
      type: yesno
      group_label: "YTD|MTD fields"
      sql: EXTRACT(DAY FROM ${date_date}) < EXTRACT(DAY FROM current_date() );;
    }


#Is before year to date.
    dimension: is_before_YTD {
      type: yesno
      group_label: "YTD|MTD fields"
      sql: EXTRACT(DAYOFYEAR FROM ${date_date}) < EXTRACT(DAYOFYEAR FROM (current_date() ));;
    }

# Finds the current month
    dimension: is_the_current_month {
      type: yesno
      group_label: "YTD|MTD fields"
      sql: EXTRACT(MONTH FROM ${date_date}) = EXTRACT(MONTH FROM (current_date() ))
            AND EXTRACT(YEAR FROM ${date_date}) = EXTRACT(YEAR FROM (current_date() ))
            ;;
    }

# Finds the current month (for both years)
    dimension: is_current_month_both_years {
      type: yesno
      group_label: "YTD|MTD fields"
      sql: EXTRACT(MONTH FROM ${date_date}) = EXTRACT(MONTH FROM (current_date() ))
        ;;
    }




    dimension: orders {
      type: number
      sql: ${TABLE}.Orders ;;
    }

    dimension: region {
      type: string
      sql: ${TABLE}.Region ;;
    }

    dimension: sales {
      type: number
      sql: ${TABLE}.Sales ;;
    }


#Custom measures
    measure: total_revenue {
      label: "Total Revenue"
      type: sum
      value_format_name: gbp_0
      sql: ${sales} ;;
    }


    measure: total_orders {
      type: sum
      sql: ${orders} ;;
    }


#  Assigns region to country name.

    dimension: country {
      type: string
      sql: CASE WHEN ${region} = "Dyson FR" THEN "France"
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
                ELSE NULL
            END ;;


        link: {
          label: "{{sap.country._value}} SAP report"
          url: "/dashboards/55?Country={{ sap.country._value | encode_uri }}"
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

        # Adds drill down links to country maps
        link: {
          label: "{{sap.country._value}} SAP report"
          url: "/dashboards/55?Country={{ sap.country._value | encode_uri }}"
          icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
        }
      }


      dimension: country_code {
        type: string
        sql: case when ${country} = 'United Kingdom' then 'UK'
              when ${country} = 'Germany' then 'DE'
              when ${country} = 'France' then 'FR'
              when ${country} = 'Japan' then 'JP'
              when ${country} = 'United States' then 'US'
              when ${country} = 'Canada' then 'CA'
              when ${country} = 'Spain' then 'ES'
              when ${country} = 'Sweden' then 'SE'
              when ${country} = 'Norway' then 'NO'
              when ${country} = 'Denmark' then 'DK'
              when ${country} = 'Austria' then 'AT'
              when ${country} = 'Australia' then 'AU'
              when ${country} = 'Belguim' then 'BE'
              when ${country} = 'Italy' then 'IT'
              when ${country} = 'Korea' then 'KR'
              when ${country} = 'China' then 'CN'
              when ${country} = 'Switzerland' then 'CH'
              when ${country} = 'Russia' then 'RU'
              when ${country} = 'Mexico' then 'MX'
              when ${country} = 'Brazil' then 'BR'
              when ${country} = 'Netherlands' then 'NL'
              when ${country} = 'Poland' then 'PL'
              when ${country} = 'India' then 'IN'
              when ${country} = 'Hong Kong' then 'HK'
              when ${country} = 'Ireland' then 'IL'
              when ${country} = 'Finland' then 'FI'
              when ${country} = 'Singapore' then 'SG'


 else null
          end;;
      }


# Concatenates country code with icon - doesn't work on all browsers

      dimension: country_and_icon {
        type: string
        sql: concat(${country_icon},' ', ${country_code}) ;;
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
      }



      measure: revenue_this_month {
        type: sum
        value_format_name: gbp_0
        group_label: "Custom SAP measures"
        sql: ${sales} ;;
        filters: {
          field: date_month
          value: "this month"
        }
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
        html: £{{rendered_value}} ;;
      }



      measure: revenue_change_on_last_year{
        group_label: "Custom SAP measures"
        type: number
        sql: 1.0 * ((${revenue_this_year}-${revenue_last_year})/NULLIF(${revenue_last_year},0))  ;;
        value_format_name: percent_2
      }




# Days lapsed in 2018 and % through 2018
      dimension: days_elapsed_2018 {
        type: number
        label: "Days lapsed in 2018"
        group_label: "YTD|MTD fields"
        sql:  date_diff(current_date(), date(2018,01,01), day)  ;;
      }

      measure: percent_through_2018 {
        type: average
        label: "Percent through 2018"
        group_label: "Custom SAP measures"
        sql:  ${days_elapsed_2018}/365  ;;
        value_format_name: percent_2
      }


# This bit works!
# Finds the 1st day of current month
      dimension: first_day_of_current_month {
        group_label: "YTD|MTD fields"
        sql:  DATE_TRUNC(current_date(), MONTH) ;;
      }



# Gerard recommends with + 1
# Days lapsed in current month
      dimension: days_elapsed_current_month {
        type:  number
        label: "Days lapesed this month"
        group_label: "YTD|MTD fields"
        sql:  date_diff(current_date(), ${first_day_of_current_month}, day)  ;;
      }


      measure: percent_through_month {
        type: average
        label: "Percent through this month"
        group_label: "Custom SAP measures"
        sql:  ${days_elapsed_current_month}/${days_in_the_month}  ;;
        value_format_name: percent_1
      }

# Remove this after we get working calc for hours through the month working. NEEDS CHANGING
      measure: percent_through_august {
        type: number
        label: "Percent through August"
        group_label: "Custom SAP measures"
        sql:  0.017  ;;
        value_format_name: percent_1
      }


# Finds the number of days in the current month
      dimension: days_in_the_month {
        sql:  DATE_DIFF(DATE_TRUNC(DATE_ADD(${date_date}, INTERVAL 1 MONTH), MONTH),
          DATE_TRUNC(${date_date}, MONTH), DAY) ;;
      }





measure: percent_of_daily_target_achieved {
  type: number
  sql: ${sap_prim.total_revenue}/${sap_6plus6.daily_target};;
  value_format_name: percent_1
}



# Measures pulled in from from SAP 6+6
# Use this for last week's performance vs target


  measure: number_of_days_in_month {
    type: average
    sql: ${days_in_the_month} ;;
  }

# references a 6plus6 dimension
#
#   dimension: revenue6plus {
#     type: number
#     sql: ${sap_6plus6.revenue6plus} ;;
#   }
#
#
#   measure: revenue_forcast_LE{
#     label: "LE 6+6 target"
#     type: sum
#     value_format: "0.0,,\" M\""
#     sql: ${revenue6plus} ;;
#     html: £{{rendered_value}} ;;
#   }
#
#
#
#   measure: revneue_forcast_this_month {
#     label: "LE 6+6 target this month"
#     type: sum
#     value_format: "0.0,,\" M\""
#     sql: ${revenue6plus};;
#     filters: {
#       field: date_month
#       value: "this month"
#     }
#     html: £{{rendered_value}} ;;
#   }



      measure: count {
        type: count
        drill_fields: []
      }
    }
