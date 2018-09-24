- dashboard: q1_do_360_robots_work_while_we_work
  title: 'Q1: Do 360° robots work while we work?'
  layout: newspaper
  elements:
  - title: Peak 360° cleaning hour
    name: Peak 360° cleaning hour
    model: google_analytics_block
    explore: robot_viz_contest
    type: single_value
    fields:
    - robot_viz_contest.number_of_cleans
    - robot_viz_contest.utc_hour_of_day
    fill_fields:
    - robot_viz_contest.utc_hour_of_day
    filters:
      robot_viz_contest.utc_date: 1 years
      robot_viz_contest.country: United Kingdom
    sorts:
    - robot_viz_contest.number_of_cleans desc
    limit: 500
    query_timezone: UTC
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    value_format: \00:"00 hrs "
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields:
    - robot_viz_contest.number_of_cleans
    row: 3
    col: 0
    width: 5
    height: 2
  - name: <p><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/cleanign.jpg"
      alt="" /></p>
    type: text
    title_text: <p><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/cleanign.jpg"
      alt="" /></p>
    body_text: ''
    row: 0
    col: 0
    width: 5
    height: 3
  - title: Peak 360° robot cleaning month
    name: Peak 360° robot cleaning month
    model: google_analytics_block
    explore: robot_viz_contest
    type: single_value
    fields:
    - robot_viz_contest.number_of_cleans
    - robot_viz_contest.utc_month_name
    fill_fields:
    - robot_viz_contest.utc_month_name
    filters:
      robot_viz_contest.utc_date: 1 years
      robot_viz_contest.country: United Kingdom
    sorts:
    - robot_viz_contest.number_of_cleans desc
    limit: 500
    column_limit: 50
    query_timezone: UTC
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    value_format: \00:"00 hrs "
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields:
    - robot_viz_contest.number_of_cleans
    listen: {}
    row: 7
    col: 0
    width: 5
    height: 2
  - title: Peak 360° cleaning day
    name: Peak 360° cleaning day
    model: google_analytics_block
    explore: robot_viz_contest
    type: single_value
    fields:
    - robot_viz_contest.number_of_cleans
    - robot_viz_contest.utc_day_of_week
    fill_fields:
    - robot_viz_contest.utc_day_of_week
    filters:
      robot_viz_contest.utc_date: 1 years
      robot_viz_contest.country: United Kingdom
    sorts:
    - robot_viz_contest.number_of_cleans desc
    limit: 500
    column_limit: 50
    query_timezone: UTC
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    value_format: \00:"00 hrs "
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields:
    - robot_viz_contest.number_of_cleans
    listen: {}
    row: 5
    col: 0
    width: 5
    height: 2
  - name: merge-amVFyOODOrflat9deRvokx-2013
    type: text
    title_text: Do 360° robots clean whilst we shop?
    subtitle_text: This item contains data that can no longer be displayed.
    body_text: This item contains results merged from two or more queries. This is
      currently not supported in LookML dashboards.
    row: 0
    col: 5
    width: 10
    height: 9
  - name: merge-726cBgl5VhmORtvxs5WjNc-2014
    type: text
    title_text: Do 360° robots clean whilst we shop?
    subtitle_text: This item contains data that can no longer be displayed.
    body_text: This item contains results merged from two or more queries. This is
      currently not supported in LookML dashboards.
    row: 0
    col: 15
    width: 9
    height: 9
