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

  dimension: channel {
    type: string
    sql: ${TABLE}.sap_6plus6_channel ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.sap_6plus6_country ;;
  }

  set: detail {
    fields: [day_date]
  }
}
