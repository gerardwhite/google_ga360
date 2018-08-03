connection: "bq2look"

# include all the views
include: "*.view"


week_start_day: monday

datagroup: bqml_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}

# explore: fan_interest_regression_evaluation {
#   label: "Regression Model Evaulation"
#   group_label: "Data Science (Demo)"
#
# }


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


#not used in demo bnut keep code
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
