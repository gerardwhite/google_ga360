
# Replaced with static table whilst we wait for Google Drive access
view: age_gender {
  sql_table_name: ao_looker_test.Age_Gender_Country ;;

  dimension: age {
    type: string
    sql: ${TABLE}.Age ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.Sessions ;;
  }

  # Sums the sessions
  measure: total_visits  {
    type: sum
    sql: ${sessions} ;;
  }

  measure: male_visits  {
    type: sum
    sql: ${sessions} ;;
    filters: {
      field: gender
      value: "male"
    }
  }

  # Multiplied by -1 to flip against axis
  measure: female_visits  {
    type: sum
    sql: ${sessions}*-1 ;;
    filters: {
      field: gender
      value: "female"
    }
  }

  # Sets website for country - so dashboard filters can apply. NB this is an incomplete list. Just using for testing.
  dimension: website {
    type: string
#     Transforming as 6plus6 data requires a clean
    sql: CASE WHEN ${TABLE}.country = "France" THEN "www.dyson.fr"
            WHEN ${TABLE}.country = "United States" THEN "www.dyson.com"
            WHEN ${TABLE}.country = "United Kingdom" THEN "www.dyson.co.uk"
            WHEN ${TABLE}.country = "China" THEN "www.dyson.cn"
            WHEN ${TABLE}.country = "Japan" THEN "www.dyson.co.jp"
            WHEN ${TABLE}.country = "Germany" THEN "www.dyson.de"
            WHEN ${TABLE}.country = "Spain" THEN "www.dyson.es"
            WHEN ${TABLE}.country = "Canada" THEN "www.dysoncanada.ca"
            WHEN ${TABLE}.country = "Italy" THEN "www.dyson.it"
            WHEN ${TABLE}.country = "India" THEN "www.dyson.in"
            END ;;

  }



  measure: count {
    type: count
    drill_fields: []
  }
}
