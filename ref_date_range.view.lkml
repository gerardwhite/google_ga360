#GW: For every date in range, and combo of country and channel

view: ref_date_range {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql: SELECT *
          FROM UNNEST(
          GENERATE_DATE_ARRAY(DATE('2017-01-01'), DATE('2018-12-31'), INTERVAL 1 DAY)
          ) AS day
          cross join (
      --

      SELECT distinct
        sap_6plus6.Channel  AS sap_6plus6_channel,
        CASE WHEN sap_6plus6.Region = "10 - Great Britain" THEN "United Kingdom"
                      WHEN sap_6plus6.Region = "30 - USA " THEN "United States"
                      WHEN sap_6plus6.Region = "41 - Mexico" THEN "Mexico"
                      WHEN sap_6plus6.Region = "45 - Canada " THEN "Canada"
                      WHEN sap_6plus6.Region = "50 - Ireland " THEN "Ireland"
                      WHEN sap_6plus6.Region = "51 - Germany " THEN "Germany"
                      WHEN sap_6plus6.Region = "52 - Austria " THEN "Austria"
                      WHEN sap_6plus6.Region = "53 - France " THEN "France"
                      WHEN sap_6plus6.Region = "55 - Spain " THEN "Spain"
                      WHEN sap_6plus6.Region = "56 - Switzerland " THEN "Switzerland"
                      WHEN sap_6plus6.Region = "58 - Belgium " THEN "Belguim"
                      WHEN sap_6plus6.Region = "85 - India" THEN "India"
                      WHEN sap_6plus6.Region = "88 - China - Beijing" THEN "China"
                      WHEN sap_6plus6.Region = "57 - Netherlands" THEN "Netherlands"
                      WHEN sap_6plus6.Region = "92 - Australia " THEN "Australia"
                      WHEN sap_6plus6.Region = "63 - Russia " THEN "Russia"
                      WHEN sap_6plus6.Region = "61 - Sweden " THEN "Sweden"
                      WHEN sap_6plus6.Region = "59 - Denmark Sub " THEN "Denmark"
                      WHEN sap_6plus6.Region = "90 - Japan " THEN "Japan"
                      WHEN sap_6plus6.Region = "64 - Finland Sub" THEN "Finland"
                      WHEN sap_6plus6.Region = "86 - Korea" THEN "Korea"
                      WHEN sap_6plus6.Region = "60 - Norway " THEN "Norway"
                      WHEN sap_6plus6.Region = "62 - Italy " THEN "Italy"
                      WHEN sap_6plus6.Region = "8A - China - Hangzhou" THEN "China"
                      WHEN sap_6plus6.Region = "67 - Poland" THEN "Poland"
                      WHEN sap_6plus6.Region = "91 - Singapore " THEN "Singapore"
                      WHEN sap_6plus6.Region = "89 - China - Shanghai" THEN "China"
                      WHEN sap_6plus6.Region = "60 - Norway " THEN "Norway"
                      WHEN sap_6plus6.Region = "9A - New Zealand " THEN "New Zealand"
                      WHEN sap_6plus6.Region = "9A - New Zealand" THEN "New Zealand"


                      ELSE sap_6plus6.Region
                  END  AS sap_6plus6_country
      FROM ao_looker_test.sap_6plus6  AS sap_6plus6)
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: day {
    type: time
    timeframes: [date]
    sql: ${TABLE}.day ;;
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
    sql: ${TABLE}.day ;;
  }



  dimension: channel {
    hidden: yes
    type: string
    sql: ${TABLE}.sap_6plus6_channel ;;
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


  dimension: country {
    type: string
    sql: ${TABLE}.sap_6plus6_country ;;
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



######## -  Date calculations  -  ##################

# Finds the number of days in the current month
  dimension: days_in_the_month {
    hidden: yes
    sql:  DATE_DIFF(DATE_TRUNC(DATE_ADD(${day_date}, INTERVAL 1 MONTH), MONTH),
      DATE_TRUNC(${day_date}, MONTH), DAY) ;;
  }


  measure: number_of_days_in_month {
    type: average
    sql: ${days_in_the_month} ;;
  }


####### - Metrics pulled into view from sap_6plus6   #############

  dimension: revenue6plus {
    type: number
    sql: ${sap_6plus6.revenue6plus} ;;
  }

  measure: revenue_forcast_LE{
    label: "LE 6+6 target"
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${revenue6plus} ;;
    html: £{{rendered_value}} ;;
  }

# Divides monthly target by days in this month
  measure: daily_target {
    label: "LE 6+6 daily target"
    type:  number
    value_format_name: gbp_0
    sql:  sum(${revenue6plus})/${number_of_days_in_month};;
  }





  set: detail {
    fields: [day_date]
  }
}
