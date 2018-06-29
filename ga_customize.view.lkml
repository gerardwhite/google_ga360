include: "ga_block.view.lkml"

explore: ga_sessions_block {
  extends: [ga_sessions_base]
  extension: required

  always_filter: {
    filters: {
      field: ga_sessions.partition_date
      value: "7 days ago for 7 days"
      ## Partition Date should always be set to a recent date to avoid runaway queries
   }
  filters: {
    field: ga_sessions.website_picker
    value: "www.dyson.co.uk"
  }
  }
}

view: ga_sessions {
  extends: [ga_sessions_base]
  # The SQL_TABLE_NAME must be replaced here for date partitioned queries to work properly. There are several
  # variations of sql_table_name patterns depending on the number of Properties (i.e. websites) being used.


  # SCENARIO 1: Only one property
  # sql_table_name: `dyson-ga.15754036.ga_sessions_*` ;;

  # SCENARIO 2: Multiple properties. The property will dynamically look at the selected dataset using a filter.
  sql_table_name: {% assign prop = ga_sessions.website_selector._sql %}
  {% if prop contains 'www.dyson.ca' %} `dyson-ga.19209080.ga_sessions_*`
  {% elsif prop contains 'www.dyson.nl' %} `dyson-ga.15754036.ga_sessions_*`
  {% elsif prop contains 'www.dyson.co.uk' %} `dyson-ga.15753450.ga_sessions_*`
  {% elsif prop contains 'www.dyson.com' %} `dyson-ga.15753478.ga_sessions_*`


  {% elsif prop contains 'www.dyson.dk' %} `dyson-ga.15753540.ga_sessions_*`
  {% elsif prop contains 'www.dyson.ie' %} `dyson-ga.15753547.ga_sessions_*`
  {% elsif prop contains 'www.dyson.at' %} `dyson-ga.15753659.ga_sessions_*`
  {% elsif prop contains 'www.dyson.com.au' %} `dyson-ga.15753684.ga_sessions_*`
  {% elsif prop contains 'www.dyson.cn' %} `dyson-ga.15753718.ga_sessions_*`
  {% elsif prop contains 'www.dyson.fr' %} `dyson-ga.15753748.ga_sessions_*`
  {% elsif prop contains 'www.dyson.it' %} `dyson-ga.15753993.ga_sessions_*`
  {% elsif prop contains 'www.dyson.co.jp' %} `dyson-ga.15754005.ga_sessions_*`
  {% elsif prop contains 'www.dyson.ch' %} `dyson-ga.15754096.ga_sessions_*`
  {% elsif prop contains 'fi.dyson.com' %} `dyson-ga.15754211.ga_sessions_*`
  {% elsif prop contains 'www.dyson.es' %} `dyson-ga.15754187.ga_sessions_*`
  {% elsif prop contains 'www.dyson.com.ru' %} `dyson-ga.15754364.ga_sessions_*`
  {% elsif prop contains 'www.dyson.se' %} `dyson-ga.15754524.ga_sessions_*`
  {% elsif prop contains 'www.dysoncanada.ca' %} `dyson-ga.19209080.ga_sessions_*`
  {% elsif prop contains 'www.dyson.be' %} `dyson-ga.21379335.ga_sessions_*`
  {% elsif prop contains 'www.dyson.de' %} `dyson-ga.60583535.ga_sessions_*`
  {% elsif prop contains 'www.dyson.no' %} `dyson-ga.15754319.ga_sessions_*`


                  {% endif %}
                  ;;
    filter: website_picker {
      suggestions: ["www.dyson.ca", "www.dyson.com", "www.dyson.nl", "www.dyson.co.uk", "www.dyson.dk", "www.dyson.ie","www.dyson.at" ,"www.dyson.com.au" ,"www.dyson.cn" ,"www.dyson.fr" ,"www.dyson.it" ,"www.dyson.co.jp" ,"www.dyson.nl" ,"www.dyson.ch" ,"www.dyson.es" ,"fi.dyson.com" ,"www.dyson.com.ru" ,"www.dyson.se" ,"www.dysoncanada.ca" ,"www.dyson.be" ,"www.dyson.de" ,"www.dyson.no"]
      }

    dimension: website_selector {
      type: string
      hidden: no
      sql: {% parameter website_picker %} ;;
    }

#     dimension: market {
#       type: string
#       sql: CASE WHEN ${website_picker} = "Dyson Canada" THEN "Canada"
#                 WHEN ${website_picker} = "Dyson Netherlands" THEN "Netherlands"
#                 ELSE NULL
#             END ;;
#     }


  # SCENARIO 3: Multiple properties. The property will dynamically look at the selected dataset. If using this pattern, change the partition_date definition in the ga_block file  to type: date_time (no sql clause)
#   sql_table_name:
#   (SELECT *,'Property1' AS Property
#   FROM `dyson-ga.19209080.ga_sessions_*`
#   WHERE {% condition partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %}
#
#   UNION ALL
#
#   SELECT *,'Property2' AS Property
#   FROM `dyson-ga.15754036.ga_sessions_*`
#   WHERE {% condition partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %});;
#
#
#     dimension: property {
#       sql: CASE WHEN ${TABLE}.property = 'Property1' THEN 'Dyson Canada'
#                 WHEN ${TABLE}.property = 'Property2' THEN 'Dyson Netherlands'
#                 ELSE NULL
#            END
#         ;;
#     }





  # If you have custom dimensions on sessions, declare them here.

  # dimension: custom_dimension_2 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=2) ;;
  # }


  # dimension: custom_dimension_2 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=2) ;;
  # }

  # dimension: custom_dimension_3 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=3) ;;
  # }

}

view: geoNetwork {
  extends: [geoNetwork_base]
}

view: totals {
  extends: [totals_base]
}

view: trafficSource {
  extends: [trafficSource_base]
}

view: device {
  extends: [device_base]
}

view: hits {
  extends: [hits_base]
}

view: hits_page {
  extends: [hits_page_base]
}

# -- Ecommerce Fields

view: hits_transaction {
  extends: [hits_transaction_base]  # Comment out to remove fields
}

view: hits_item {
  extends: [hits_item_base]
}

# -- Advertising Fields

view: adwordsClickInfo {
  #extends: [adwordsClickInfo_base]
}

view: hits_publisher {
  #extends: [hits_publisher_base]   # Comment out this line to remove fields
}

#  We only want some of the interaction fields.
view: hits_social {
  extends: [hits_social_base]

  dimension: socialInteractionNetwork {hidden: yes}

  dimension: socialInteractionAction {hidden: yes}

  dimension: socialInteractions {hidden: yes}

  dimension: socialInteractionTarget {hidden: yes}

  #dimension: socialNetwork {hidden: yes}

  dimension: uniqueSocialInteractions {hidden: yes}

  #dimension: hasSocialSourceReferral {hidden: yes}

  dimension: socialInteractionNetworkAction {hidden: yes}
}


view: hits_appInfo {
  extends: [hits_appInfo_base]
}

view: hits_eventInfo {
  extends: [hits_eventInfo_base]
  dimension: play {
    sql: ${eventAction} = "play" ;;
    type: yesno
  }
}


view: hits_customDimensions {
  extends: [hits_customDimensions_base]
}

view: hits_customVariables {
  extends: [hits_customVariables_base]
}

# Required calculated fields
# Average order value (AOV)
# Value per session
# 'Segment data' for example shop visits
# Conversion rate (transactions / sessions)
