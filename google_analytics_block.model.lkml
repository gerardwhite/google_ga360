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

explore: weekly_global_stats {
  description: "Used to compare markets on a high level before drilling. Based on aggregate table"
  join: tax_xrates_by_country_2018_v2 {
    relationship: many_to_one
    sql_on: ${weekly_global_stats.ga_sessions_website_selector} = ${tax_xrates_by_country_2018_v2.website} ;;
    fields: [tax_xrates_by_country_2018_v2.country, tax_xrates_by_country_2018_v2.country_icon, tax_xrates_by_country_2018_v2.country_and_icon]
  }
}
