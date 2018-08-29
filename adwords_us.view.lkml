view: adwords_us {
  label: "Adwords"
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





  dimension: adgroup_type {
    type: string
    sql: case when ${keyword} = '(content targeting)' then 'Display'
    when ${keyword} = '(User vertical targeting)' then 'Display'
    when ${keyword} LIKE '%Home &' then 'Display'
    else "Search"
    END ;;
    }


# measures
measure: total_clicks {
  label: "Clicks"
  type: sum
  sql: ${clicks} ;;
}

  measure: total_impressions {
    label: "Impressions"
    type: sum
    sql: ${impressions} ;;
  }

  measure: total_cost {
    label: "Cost"
    type: sum
    value_format_name: usd_0
    sql: ${cost} ;;
  }

  measure: cost_per_click {
    type: average
    label: "CPC"
    value_format_name: usd
    sql: ${cpc} ;;
  }

measure: click_through_rate {
  label: "CTR"
  type: average
  value_format_name: percent_1
  sql: ${clicks}/${impressions} ;;
}


  measure: count {
    type: count
    drill_fields: []
  }
}
