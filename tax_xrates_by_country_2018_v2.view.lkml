view: tax_xrates_by_country_2018_v2 {
  view_label:"Reference Data"
  sql_table_name: ao_looker_test.tax_xrates_by_country_2018_v2 ;;




  dimension: country {
#     hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;

    link: {
      label: "{{tax_xrates_by_country_2018_v2.country_and_icon._value}} Dashboard"
      url: "/dashboards/8?Property={{ weekly_global_stats.ga_sessions_website_selector._value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: country_icon {
    type: string
    sql: case when ${country} = 'United Kingdom' then '🇬🇧'
              when ${country} = 'Germany' then '🇩🇪'
              when ${country} = 'France' then '🇫🇷'
              when ${country} = 'Japan' then '🇯🇵'
              when ${country} = 'United States' then '🇺🇸'
 else null
          end;;
  }

  dimension: country_and_icon {
    type: string
    sql: concat(${country_icon},' ', ${country}) ;;
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
