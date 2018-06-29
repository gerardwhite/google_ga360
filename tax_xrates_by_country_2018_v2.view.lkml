view: tax_xrates_by_country_2018_v2 {
  sql_table_name: ao_looker_test.tax_xrates_by_country_2018_v2 ;;




  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: countrycode {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: currencycode {
    hidden: yes
    type: string
    sql: ${TABLE}.currencycode ;;
  }

  dimension: vat {
    hidden: yes
    type: number
    sql: ${TABLE}.vat ;;
  }

  dimension: website {
    hidden: yes
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: xrate {
    hidden: yes
    type: number
    sql: ${TABLE}.xrate ;;
  }


}
