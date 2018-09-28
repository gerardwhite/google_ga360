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
  # Counts the size of the data group tables and looks for a change here.
  sql_trigger: SELECT
              (select count(*)  FROM `dyson-ga.ao_looker_test.SAP` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.sap_6plus6` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.sap_budget` ) ;;
}


datagroup: retail_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT
              (select count(*)  FROM `dyson-ga.ao_looker_test.Retail` )
              +
              (select count(*) FROM `dyson-ga.ao_looker_test.Footfall` ) ;;
  }

# We'll use this trigger when we join realtime today to last year
# datagroup: realtime_datagroup {
#   max_cache_age: "1 hour"
#   sql_trigger: SELECT
#               (select count(*)  FROM `dyson-ga.ao_looker_test.ga_realtime_today` )
#               +
#               (select count(*) FROM `dyson-ga.ao_looker_test.ga_realtime_today` ) -- update this for realtime last year ;;
# }



explore: rt_web_sessions {
  label: "Adobe"
  group_label: "E-Commerce"

}


explore: adobe_product_performance {
  label: "Adobe | Product Performance"
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


 # Old join when using static temp data
  # join: uk_temperatures {
  #   relationship: many_to_one
  #   sql_on: ${ga_sessions.visitStart_date} = ${uk_temperatures.temp_date} ;;
  # }
}


# #not used in demo but keep code
# explore: weekly_global_stats {
#   label: "Google Analytics: Global"
#   group_label: "E-Commerce"
#   description: "Used to compare markets on a high level before drilling. Based on aggregate table"
#   join: tax_xrates_by_country_2018_v2 {
#     relationship: many_to_one
#     sql_on: ${weekly_global_stats.ga_sessions_website_selector} = ${tax_xrates_by_country_2018_v2.website} ;;
#     fields: [tax_xrates_by_country_2018_v2.country, tax_xrates_by_country_2018_v2.country_icon, tax_xrates_by_country_2018_v2.country_and_icon]
#   }
# }






# SAP all unions in both target and budget data to the actuals.  Check the view sap_all to see how this works.
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


explore: retail_next {
  persist_for: "30 minutes"
  group_label: "Retail"
  description: "Data collected by retail next for certain Dyson retail stores (not all). Collects entry and exit signals for people passing through our stores.
  Joins this to weather feed for associated store location."
  label: "Retail | Footfall & Weather"
  join: weather_by_store {
    relationship: many_to_one
    sql_on: ${retail_next.store} = ${weather_by_store.store} ;;
  }
}





# explore: retail  {
#   persist_for: "1 hour"
#   group_label: "Retail"
#   label: "Retail | Sales"
#   always_filter: {
#     filters: {
#       field: retail.date_date
#       value: "14 days ago for 14 days"
#     }
#     filters: {
#       field: retail.store
#       value: "Oxford Street"
#     }
#   }
# }
#
# explore: footfall  {
#   persist_for: "1 hour"
#   group_label: "Retail"
#   label: "Retail | Footfall"
#   always_filter: {
#     filters: {
#       field: footfall.date_date
#       value: "14 days ago for 14 days"
#     }
#     filters: {
#       field: footfall.store
#       value: "Oxford Street"
#     }
#   }
# }

# Unions all retail datasets using GW's data logic from SAP example.  Masked out as we have a live footfall data.



########### Marketplaces ###################

# explore: tmall {
#   group_label: "Marketplaces"
#   label: "Marketplaces | Tmall"

# }


########## GA Realtime ####################

# explore: ga_realtime_today {
#   group_label: "E-Commerce"
#   label: "Google Analytics | Realtime"

# }


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
  }
}


################## OTHER/BESPOKE/CUSTOM stuff ########################

# Age and gender metrics not available in BigQuery. This is a workaround using a sheets extract schedule.
# Note to get sheets data into BigQuery you need to enable the Google Drive API AND add the looker access key to the Google Sheet
# The Google Sheet also needs to be set up to have column headers in the top row and with no blank rows.
# Service account email required is as follows: looker@dyson-ga.iam.gserviceaccount.com

explore: age_gender {
  persist_for: "4 hours"
  group_label: "E-Commerce"
  label: "Age & Gender"
}



# # Adhoc analysis for Japanese trade-in campaign
# explore: adhoc_jp_trade_in_campaign {
#   group_label: "_Adhoc analysis"
#   label: "Trade in campaign explorer | Japan"
#   join: tax_xrates_by_country_2018_v2 {
#     relationship: many_to_one
#     sql_on: ${adhoc_jp_trade_in_campaign.website} = ${tax_xrates_by_country_2018_v2.website} ;;
#   }
# }


################## THESE EXPLORES NEED TO DELETE POST POC ######################

################## Adwords cost and clicks #####################################

# This will be replaced with the new connection block to DoubelClick once we have access.

# explore: adwords_us {
#   persist_for: "4 hours"
#   group_label: "E-Commerce"
#   label: "Adwords | US"
# }

# explore: usadwords_merge  {
#   persist_for: "4 hours"
#   group_label: "E-Commerce"
#   label: "Adwords | US Merge"
# }

# explore: adwords_jp2 {
#   persist_for: "4 hours"
#   group_label: "E-Commerce"
#   label: "Adwords | JP Merge"
# }

# explore: tmall_products {
#   persist_for: "4 hours"
#   group_label: "Marketplaces"
#   label: "Tmall | Product Performance"
# }

################## Robot viz contest - DELETE AFTER SUMMIT ####


# explore: robot_viz_contest {
#   persist_for: "1 hour"
#   group_label: "Robot Viz Contest"
#   label: "Robot viz | Deletes after summit"

#   join: robot_facts {
#     relationship: many_to_one
#     sql_on: ${robot_viz_contest.serial_ref} = ${robot_facts.serial_ref} ;;
#   }

# join: robot_reference_data  {
#   relationship: many_to_one
#   sql_on: ${robot_viz_contest.country} = ${robot_reference_data.country} ;;
# }

# }
