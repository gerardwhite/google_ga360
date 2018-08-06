connection: "bq2look"

# include all the views
include: "*.view"


week_start_day: monday

datagroup: bqml_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}


explore: rt_web_sessions {
  label: "Adobe"
  group_label: "E-Commerce"

}


explore: ga_sessions {
  label: "Google Analytics"
  group_label: "E-Commerce"
  extends: [ga_sessions_block]
  join: tax_xrates_by_country_2018_v2 {
    relationship: many_to_one
    sql_on: ${ga_sessions.website_selector} = ${tax_xrates_by_country_2018_v2.website} ;;
  }

  join: uk_temperatures {
    relationship: many_to_one
    sql_on: ${ga_sessions.visitStart_date} = ${uk_temperatures.temp_date} ;;
  }
}


#not used in demo but keep code
explore: weekly_global_stats {
  label: "Google Analytics: Global"
  group_label: "E-Commerce"
  description: "Used to compare markets on a high level before drilling. Based on aggregate table"
  join: tax_xrates_by_country_2018_v2 {
    relationship: many_to_one
    sql_on: ${weekly_global_stats.ga_sessions_website_selector} = ${tax_xrates_by_country_2018_v2.website} ;;
    fields: [tax_xrates_by_country_2018_v2.country, tax_xrates_by_country_2018_v2.country_icon, tax_xrates_by_country_2018_v2.country_and_icon]
  }
}





###### Ref date range to build an array. Not sure if we need this as have SAP data for every day date - ######

explore: fill_in_dates {
  group_label: "SAP"
  label: "SAP | Test join2"
  join: sap_6plus6 {
    type: left_outer
    relationship: one_to_one
    sql_on: ${fill_in_dates.day_date}=${sap_6plus6.month_date} ;;
  }
}

# Gerards work for joining to ref data

# explore: ref_date_range {
#   group_label: "SAP"
#   label: "SAP | Test join2 - with more joins"
#   join: sap_6plus6 {
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${ref_date_range.day_date}=${sap_6plus6.month_date}
#             AND ${ref_date_range.channels} = ${sap_6plus6.channels}
#             AND ${ref_date_range.country} = ${ref_date_range.country};;
#   }
# }


###### - Working join SAP | SAP 6+6 - ######
explore: sap_prim {
  from: sap
  group_label: "SAP"
  label: "SAP | Test join3"
  join: sap_6plus6 {
    type: left_outer
    relationship: one_to_one
    sql_on: ${sap_prim.country}=${sap_6plus6.country}
    AND ${sap_prim.channel}=${sap_6plus6.channels}
    AND ${sap_prim.date_month}=${sap_6plus6.month_month}
    AND ${sap_prim.date_year}=${sap_6plus6.month_year} ;;
  }
}





################## SAP ########################

# explore: sap {
#   persist_for: "1 hour"
#   group_label: "SAP"
#   label: "SAP | Actual revenue"
#   always_filter: {
#     filters: {
#       field: sap.date_date
#       value: "30 days ago for 30 days"
#     }
#   }
# }


explore: sap_6plus6 {
  persist_for: "1 hour"
  group_label: "SAP"
  label: "SAP | Revenue (6+6 LE)"
  always_filter: {
    filters: {
      field: sap_6plus6.month_date
      value: "30 days ago for 30 days"
    }
  }
}


explore: sap_budget {
  persist_for: "1 hour"
  group_label: "SAP"
  label: "SAP | Budget revenue"
  always_filter: {
    filters: {
      field: sap_budget.month_date
      value: "30 days ago for 30 days"
    }
  }

}







################## GFK ########################
explore: gfk {
  persist_for: "1 hour"
  group_label: "GFK"
  label: "GFK | All"
  always_filter: {
    filters: {
      field: gfk.date_collected_date
      value: "14 days ago for 14 days"
    }
    filters: {
      field: gfk.country
      value: "France"
    }
  }
}



# Joins pages on lookup to URL
explore: view_pages_last30days_allmarkets {
  group_label: "GFK"
  label: "GFK | Pages + URLs"
  join: view_pagelookup_allmarkets{
    relationship: many_to_one
    # Just uses the page URL field:
    fields: [view_pagelookup_allmarkets.page_url]
    # Joins on pagePath AND country
    sql_on: ${view_pages_last30days_allmarkets.page_path} = ${view_pagelookup_allmarkets.page_path}
      AND ${view_pages_last30days_allmarkets.country} = ${view_pagelookup_allmarkets.country} ;;
  }
  always_filter: {
    filters: {
      field: view_pages_last30days_allmarkets.partition_date
      value: "14 days ago for 14 days"
    }
    filters: {
      field: view_pages_last30days_allmarkets.country
      value: "France"
    }
  }
}

# Product transaction data

explore: products_historical_allmarkets {
  group_label: "GFK"
  label: "GFK | Product revenue"
  join: image_urls3_looker {
    relationship: many_to_one
    sql_on: ${products_historical_allmarkets.product_sku} = ${image_urls3_looker.sku} ;;
  }
  always_filter: {
    filters: {
      field: products_historical_allmarkets.partition_date
      value: "14 days ago for 14 days"
    }
    filters: {
      field: products_historical_allmarkets.country
      value: "France"
    }
  }
}


################## OTHER ########################

# Adhoc analysis for Japanese trade-in campaign
explore: adhoc_jp_trade_in_campaign {
  group_label: "_Adhoc analysis"
  label: "Trade in campaign explorer | Japan"
  join: tax_xrates_by_country_2018_v2 {
    relationship: many_to_one
    sql_on: ${adhoc_jp_trade_in_campaign.website} = ${tax_xrates_by_country_2018_v2.website} ;;
  }
}


################## DATA SCIENCE/BQML ########################

#
# explore: fan_interest_regression_evaluation {
#   label: "Regression Model Evaulation"
#   group_label: "Data Science (Demo)"
#
# }
#
# explore: ga_sessions_data_science {
#   group_label: "Data Science (Demo)"
#   label: "Google Analytics (w/ Data Science Extensions)"
#   extends: [ga_sessions]
#
#   join: fan_interest_prediction {
#     relationship: many_to_one
#     sql_on: ${ga_sessions.visitStart_date} = ${fan_interest_prediction.visitStart_date} ;;
#   }
# }
