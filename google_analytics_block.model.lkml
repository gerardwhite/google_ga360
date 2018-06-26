connection: "bq2look"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: ga_sessions {
  label: "Google Analytics"
  extends: [ga_sessions_block]
}

week_start_day: monday
# explore: canada_stats {

# }
