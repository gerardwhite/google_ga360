# Fills in dates to current date.
# GENERATE_DATE_ARRAY(DATE('2017-01-01'), CURRENT_DATE(), INTERVAL 1 DAY)
# Change current date to e.g. end of year date to populate more rows.

view: fill_in_dates {
  derived_table: {
    sql:
    SELECT day
    FROM UNNEST(
    GENERATE_DATE_ARRAY(DATE('2017-01-01'), DATE('2018-12-31'), INTERVAL 1 DAY)
    ) AS day;;
  }
  dimension_group: day {
    type: time
    sql: cast(${TABLE}.day as timestamp) ;;
  }


}
