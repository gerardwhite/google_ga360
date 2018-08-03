view: image_urls3_looker {
  #reference data

  sql_table_name: ao_looker_test.image_urls3_looker ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: image {
    type: string
    sql: ${TABLE}.Image ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.Product ;;
  }

  dimension: reviews {
    type: string
    sql: ${TABLE}.Reviews ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.Score ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.SKU ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.Website ;;
  }


  dimension: sku_image {
    type: string
    sql: ${image};;
    html: <img src="{{value}}" /> ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
