connection: "bq2look"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

week_start_day: monday


explore: ga_sessions {
  label: "Google Analytics"
  extends: [ga_sessions_block]
  join: tax_xrates_by_country_2018_v2 {
    relationship: many_to_one
    sql_on: ${ga_sessions.website_selector} = ${tax_xrates_by_country_2018_v2.website} ;;
  }
}

explore: revenue_targets_by_region_2018 {
  label: "Revenue Targets"
}
