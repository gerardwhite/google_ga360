
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

  dimension: transactions {
    type: number
    sql: ${TABLE}.Transactions ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.Revenue ;;
  }


  # Sums the sessions
  measure: total_visits  {
    type: sum
    sql: ${sessions} ;;
  }


  # Sums the transactions
  measure: total_transactions  {
    type: sum
    sql: ${transactions} ;;
  }

  # Sums the revenue
  measure: local_revenue  {
    type: sum
    sql: ${revenue} ;;
  }



# Value per visit
measure: value_per_visit {
  type: number
  sql: ${local_revenue}/${total_visits} ;;
}


# Value per visit
  measure: value_per_visit_JPY {
    value_format: "0.00"
    type: number
    sql: ${local_revenue}/${total_visits} ;;
    html: ¥{{rendered_value}} ;;
  }


  measure: male_visits  {
    type: sum
    sql: ${sessions} ;;
    filters: {
      field: gender
      value: "male"
    }
  }


  measure: male_transactions  {
    type: sum
    sql: ${transactions} ;;
    filters: {
      field: gender
      value: "male"
    }
  }

  measure: male_revenue  {
    type: sum
    sql: ${revenue} ;;
    filters: {
      field: gender
      value: "male"
    }
  }


  measure: female_visits  {
    type: sum
    sql: ${sessions} ;;
    filters: {
      field: gender
      value: "female"
    }
  }

  measure: female_transactions  {
    type: sum
    sql: ${transactions} ;;
    filters: {
      field: gender
      value: "female"
    }
  }

  measure: female_revenue  {
    type: sum
    sql: ${revenue} ;;
    filters: {
      field: gender
      value: "female"
    }
  }



  # Multiplied by -1 to flip against axis
  measure: female_visits_flip  {
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
             WHEN ${TABLE}.country = "Sweden" THEN "www.dyson.se"

            END ;;

  }



  dimension: gender_icon {
    type: string
    sql: case when ${gender} = 'male' then 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/male.png'
              when ${gender} = 'female' then 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/female.png'

 else null
          end;;
    html: <img src="{{ value }}" style="height:30px;"/> ;;

  }


  dimension: age_and_gender {
    type: string
    sql: concat(${gender},'s | ', ${age}, ' years old')  ;;
  }




  measure: count {
    type: count
    drill_fields: []
  }
}
