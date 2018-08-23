view: tmall {
  sql_table_name: ao_looker_test.Tmall ;;

  dimension: category_1 {
    type: string
    sql: ${TABLE}.Category_1 ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Category_2 ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      day_of_month,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: marketplace {
    type: string
    sql: ${TABLE}.Marketplace ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.Model ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.Month ;;
  }

  dimension: qty {
    type: number
    sql: ${TABLE}.QTY ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.SKU ;;
  }

  dimension: week {
    type: string
    sql: ${TABLE}.Week ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: total_orders {
    type: sum
    sql: ${qty} ;;
  }

  ##### Custom measures examples ####
  measure: orders_last_week {
    group_label: "Calculated Tmall measures"
    type: sum
    sql: ${qty};;
    filters: {
    field: date_date
    value: "last week"
  }
  }

  measure: orders_previous_week {
    group_label: "Calculated Tmall measures"
    type: sum
    sql: ${qty};;
    filters: {
      field: date_date
      value: "2 weeks ago"
    }
  }

  measure: orders_last_month {
    group_label: "Calculated Tmall measures"
    type: sum
    sql: ${qty};;
    filters: {
      field: date_date
      value: "last month"
    }
  }

  measure: orders_previous_month {
    group_label: "Calculated Tmall measures"
    type: sum
    sql: ${qty};;
    filters: {
      field: date_date
      value: "2 months ago"
    }
  }

  ##### Comparison measures ####

  measure: last_month_on_previous_month_diff {
    group_label: "Calculated Tmall measures"
    type: number
    sql: ${orders_last_month}-${orders_previous_month} ;;
  }


  measure: last_month_on_previous_month_percent {
    group_label: "Calculated Tmall measures"
    type: number
    sql: 1.0 * ((${orders_last_month}-${orders_previous_month})/NULLIF(${orders_previous_month},0))  ;;
    value_format_name: percent_1
  }






  measure: count {
    type: count
    drill_fields: []
  }
}
