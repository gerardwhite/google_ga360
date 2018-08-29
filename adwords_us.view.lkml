view: adwords_us {
  sql_table_name: ao_looker_test.AdwordsUS ;;

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }

  dimension: cpc {
    type: number
    sql: ${TABLE}.CPC ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: Adgroup {
    type: string
    sql: ${TABLE}.Adgroup ;;
  }

  dimension: CampaignID {
    type: string
    sql: ${TABLE}.CampaignID ;;
  }


  dimension: keyword {
    type: string
    sql: ${TABLE}.Keyword ;;
  }

# measures
measure: total_clicks {
  type: sum
  sql: ${clicks} ;;
}

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
  }

  measure: total_cost {
    type: sum
    value_format_name: usd_0
    sql: ${cost} ;;
  }

  measure: cost_per_click {
    type: average
    value_format_name: usd
    sql: ${cpc} ;;
  }

measure: click_through_rate {
  type: average
  value_format_name: percent_1
  sql: ${clicks}/${impressions} ;;
}


  measure: count {
    type: count
    drill_fields: []
  }
}
