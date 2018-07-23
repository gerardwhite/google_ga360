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
    sql: case when ${country} = 'United Kingdom' then 'gbr'
              when ${country} = 'Germany' then 'deu'
              when ${country} = 'France' then 'fra'
              when ${country} = 'Japan' then 'jpn'
              when ${country} = 'United States' then 'usa'
               when ${country} = 'Canada' then 'can'
              when ${country} = 'Spain' then 'esp'
              when ${country} = 'Sweden' then 'swe'
              when ${country} = 'Norway' then 'nor'
              when ${country} = 'Denmark' then 'dnk'
              when ${country} = 'Belguim' then 'bel'
              when ${country} = 'Italy' then 'ita'
              when ${country} = 'Korea' then 'kor'
              when ${country} = 'China' then 'chn'
              when ${country} = 'Switzerland' then 'che'
              when ${country} = 'Russia' then 'rus'
              when ${country} = 'Mexico' then 'mex'

 else null
          end;;
    html: <img src="https://restcountries.eu/data/{{ value }}.svg" style="width:50px;height:30px;"/> ;;
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
