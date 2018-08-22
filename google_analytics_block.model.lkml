connection: "bq2look"

# include all the views
include: "*.view"

# sets start of week to Monday
week_start_day: monday

datagroup: bqml_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}

datagroup: sap_datagroup {
  max_cache_age: "1 hour"
  # GW: Datagroup to define a change in any of the SAP Data sources
  sql_trigger: SELECT
              (select count(*)  FROM `dyson-ga.ao_looker_test.SAP` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.sap_6plus6` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.sap_budget` ) ;;
}

# AO: retail_datagroup logic copied from GW example above.
datagroup: retail_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT
              (select count(*)  FROM `dyson-ga.ao_looker_test.Retail` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.Footfall` ) ;;
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





################## ~ SAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ############################
################## ~ ALL SAP VIEWS JOINED TOGETHER ~~ ###########################

# Joins sap and 6plus6 together using data array/scaffold
# Data array/scaffold:
explore: ref_date_range {
  group_label: "SAP"
  label: "SAP | SAP, budget & 6plus6"

# Joins SAP 6plus6 targets to data array at monthly level
  join: sap_6plus6 {
    type: left_outer
    relationship: one_to_one
    sql_on: ${ref_date_range.date_month}=${sap_6plus6.date_month}
            AND ${ref_date_range.date_year}=${sap_6plus6.date_year}
            AND ${ref_date_range.channels} = ${sap_6plus6.channels}
            AND ${ref_date_range.country} = ${sap_6plus6.country};;
  }
# Joins SAP budget figures to data array
  join: sap_budget {
    type: left_outer
    relationship: one_to_one
    sql_on: ${ref_date_range.date_month}=${sap_budget.date_month}
            AND ${ref_date_range.date_year}=${sap_budget.date_year}
            AND ${ref_date_range.channels} = ${sap_budget.channel}
            AND ${ref_date_range.country} = ${sap_budget.country};;
  }
# Joins SAP actuals to data array at daily level
  join: sap {
    type: left_outer
    relationship: one_to_one
    sql_on: ${ref_date_range.date_date}=${sap.date_date}
            AND ${ref_date_range.channels} = ${sap.channel}
            AND ${ref_date_range.country} = ${sap.country};;
  }
}





################## ~ SINGLE-LEVEL SAP EXPLORES ~~~~~~ ###########################

# # SAP actuals view:
explore: sap {
  persist_for: "1 hour"
  group_label: "SAP"
  label: "SAP | Actual revenue"
  always_filter: {
    filters: {
      field: sap.date_date
      value: "30 days ago for 30 days"
    }
  }
}
# code to exclude fields if required: [ALL_FIELDS*, -sap.percent_of_daily_target_achieved]

# SAP 6+6 targets view:
explore: sap_6plus6 {
  persist_for: "1 hour"
  group_label: "SAP"
  label: "SAP | Revenue (6+6 LE)"
  always_filter: {
    filters: {
      field: sap_6plus6.date_date
      value: "30 days ago for 30 days"
    }
  }
}
# SAP budget for 2018. Use the 6+6 in prefernce to this.
explore: sap_budget {
  persist_for: "1 hour"
  group_label: "SAP"
  label: "SAP | Budget revenue"
  always_filter: {
    filters: {
      field: sap_budget.date_date
      value: "30 days ago for 30 days"
    }
  }
}

explore: sap_all {
  group_label: "SAP"
  label: "SAP | All"
  hidden: no

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


################# Retail and footfall #############################
################# Pre- filtered for Oxford Street 14 days ago #####
# will join after testing in explores #############################

explore: retail  {
  persist_for: "1 hour"
  group_label: "Retail"
  label: "Retail | Sales"
  always_filter: {
    filters: {
      field: retail.date_date
      value: "14 days ago for 14 days"
    }
    filters: {
      field: retail.store
      value: "Oxford Street"
    }
  }
}

explore: footfall  {
  persist_for: "1 hour"
  group_label: "Retail"
  label: "Retail | Footfall"
  always_filter: {
    filters: {
      field: footfall.date_date
      value: "14 days ago for 14 days"
    }
    filters: {
      field: footfall.store
      value: "Oxford Street"
    }
  }
}

# Unions all retail datasets using GW's data logic from SAP example:

explore: retail_all {
  group_label: "Retail"
  label: "Retail | All"
  hidden: no

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
