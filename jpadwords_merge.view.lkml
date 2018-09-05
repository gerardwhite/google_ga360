view: jpadwords_merge {
    sql_table_name: ao_looker_test.JPAdwordsMerge ;;

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

    dimension: ctr {
      type: number
      sql: ${TABLE}.CTR ;;
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

# Measures...

    measure: click_through_rate {
      type: average
      sql: ${ctr}  ;;
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

    measure: count {
      type: count
      drill_fields: []
    }
  }
