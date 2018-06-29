connection: "bq2look"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

week_start_day: monday


explore: ga_sessions {
  label: "Google Analytics"
  extends: [ga_sessions_block]
}
