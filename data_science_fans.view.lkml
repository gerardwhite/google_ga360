view: fan_interest_input {
  derived_table: {

    explore_source: ga_sessions {
      column: total_visitors {}
      column: visitStart_date {}
      column: uk_average_temperature { field: uk_temp.uk_average_temperature }
      filters: {
        field: ga_sessions.partition_date
        value: "2 years"
      }
      filters: {
        field: ga_sessions.website_picker
        value: "www.dyson.co.uk"
      }
      filters: {
        field: first_page.pageTitle
        value: "%fan%,%fans%,%heatwave%,%cool%,%purifier%"
      }
      filters: {
        field: uk_temp.uk_average_temperature
        value: "NOT NULL"
      }
    }
  }
  }
