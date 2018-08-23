view: tmall {
  sql_table_name: ao_looker_test.Tmall ;;

  dimension: category_1 {
    type: string
    sql: ${TABLE}.Category_1 ;;
  }

  dimension: category_2 {
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

  measure: quantity {
    type: sum
    sql: ${qty} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
