view: sap_6plus6 {
  sql_table_name: ao_looker_test.sap_6plus6 ;;

  dimension: channel {
    hidden: yes
    type: string
    sql: ${TABLE}.Channel ;;
  }


# Channel cleanup, to 'channels' to align with SAP naming convention:
  dimension: channels {
    type: string
    sql: CASE WHEN ${channel} = "Direct_OnlineStores - Dyson Online Stores" THEN "Dyson Online Store"
            WHEN ${channel} = "Direct_Marketplaces - Dyson MarketPlaces" THEN "Dyson Marketplaces"
            WHEN ${channel} = "Direct_SalesService - Dyson Sales & Service" THEN "Dyson Sales & Service"
            WHEN ${channel} = "Direct_RetailStores - Dyson Retail Stores" THEN "Dyson Retail Stores"

  ELSE null
  END ;;

    }




    dimension: date_string {
      type: string
      sql: ${TABLE}.dateString ;;
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
    sql: ${TABLE}.monthDate ;;
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




    dimension: region {
      type: string
      sql: ${TABLE}.Region ;;
    }




    dimension: country {
      type: string
      sql: CASE WHEN ${region} = "10 - Great Britain" THEN "United Kingdom"
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


                ELSE ${region}
            END ;;


        link: {
          label: "{{sap_6plus6.country._value}} SAP report"
          url: "/dashboards/55?Country={{ sap_6plus6.country._value | encode_uri }}"
          icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/SAPfavicon.ico"
        }
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


# Finds the number of days in the current month
      dimension: days_in_the_month {
        hidden: yes
        sql:  DATE_DIFF(DATE_TRUNC(DATE_ADD(${date_date}, INTERVAL 1 MONTH), MONTH),
          DATE_TRUNC(${date_date}, MONTH), DAY) ;;
      }




      dimension: revenue6plus {
        type: number
        sql: ${TABLE}.revenue6plus ;;
      }


#Custom measures
      measure: revenue_forcast_LE{
        label: "LE 6+6 target"
        type: sum
        value_format: "0.0,,\" M\""
        sql: ${revenue6plus} ;;
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
      }


      measure: number_of_days_in_month {
        type: average
        sql: ${days_in_the_month} ;;
      }


# Use this for last week's performance vs target
  measure: daily_le7 {
    label: "Target last week based on daily LE rate"
    type:  number
    value_format_name: gbp_0
    sql:  ${daily_le_rate30}*7;;
  }


  measure: daily_le_rate {
    label: "LE 6+6 daily target this month"
    type:  number
    value_format_name: gbp_0
    sql:  ${revneue_forcast_this_month}/${number_of_days_in_month};;
  }



# Divides monthly target by days in this month
  measure: daily_target {
    label: "LE 6+6 daily target"
    type:  number
    value_format_name: gbp_0
    sql:  sum(${revenue6plus})/${number_of_days_in_month};;
  }



  measure: daily_le_rate30 {
    hidden: no
    type:  number
    value_format_name: gbp_0
    sql:  ${revneue_forcast_this_month}/30;;
  }




      measure: count {
        type: count
        drill_fields: []
      }
    }
