view: adwords_jp2 {
  sql_table_name: ao_looker_test.AdwordsJP2 ;;

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.BounceRate ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.Bounces ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: conversion_rate {
    type: number
    sql: ${TABLE}.ConversionRate ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.Duration ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.Keyword ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.Revenue ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.Transactions ;;
  }


  measure: total_impressions {
    label: "Impressions"
    type: sum
    sql: ${impressions} ;;
  }

  measure: total_clicks {
    label: "Clicks"
    type: sum
    sql: ${clicks} ;;
  }

 measure: CTR {
   type: average
  sql: ${clicks}/${impressions} ;;
 }


  measure: count {
    type: count
    drill_fields: []
  }
}
