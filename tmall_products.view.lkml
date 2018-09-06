view: tmall_products {
  sql_table_name: ao_looker_test.TmallProducts ;;

  dimension: add_to_cart {
    type: number
    sql: ${TABLE}.AddToCart ;;
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.PageViews ;;
  }

  dimension: product_covnersion {
    type: number
    sql: ${TABLE}.ProductCovnersion ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.ProductName ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.Sessions ;;
  }

  dimension: stock_rate {
    type: number
    sql: ${TABLE}.stockRate ;;
  }

  dimension: transactions {
    type: string
    sql: ${TABLE}.Transactions ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
