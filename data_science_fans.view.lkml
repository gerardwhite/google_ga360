# This file covers the new BigQuery Machine Learning functionality.
#
# A training data set is defined from an existing data model (Google Analytics in this case)
# and a regression model is created (line 38) which can be used to generate predicted visits/sales
# based on temperature.


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

view: fan_interest_regression {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='linear_reg'
        , labels=['total_visitors']
        --, min_rel_progress = 0.00001
        , eval_split_fraction= 0.2
        , max_iteration = 100
        ) AS
      SELECT
         * EXCEPT(visitStart_date)
      FROM ${fan_interest_input.SQL_TABLE_NAME};;
  }
}



# ######################## TRAINING INFORMATION #############################
# explore:  fan_interest_regression_evaluation {}
# explore: fan_interest_training {}

# VIEWS:
view: fan_interest_regression_evaluation {
  derived_table: {
    sql: SELECT * FROM ml.EVALUATE(
          MODEL ${fan_interest_regression.SQL_TABLE_NAME},
          (SELECT visitStart_date, uk_average_temperature, CAST(total_visitors as FLOAT64) as total_visitors FROM ${fan_interest_input.SQL_TABLE_NAME}));;
  }
  dimension: mean_absolute_error {type: number}
  dimension: mean_squared_error {type: number}
  dimension: mean_squared_log_error {type: number}
  dimension: median_absolute_error {type: number}
  dimension: r2_score {type: number}
  dimension: explained_variance {type: number}
}

view: fan_interest_training {
  derived_table: {
    sql: SELECT  * FROM ml.TRAINING_INFO(MODEL ${fan_interest_regression.SQL_TABLE_NAME});;
  }
  dimension: training_run {type: number}
  dimension: iteration {type: number}
  dimension: loss {type: number}
  dimension: eval_loss {type: number}
  dimension: duration_ms {label:"Duration (ms)" type: number}
  dimension: learning_rate {type: number}
  measure: iterations {type:count}
  measure: total_loss {
    type: sum
    sql: ${loss} ;;
  }
  measure: total_training_time {
    type: sum
    label:"Total Training Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  measure: average_iteration_time {
    type: average
    label:"Average Iteration Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  set: detail {fields: [training_run,iteration,loss,eval_loss,duration_ms,learning_rate]}
}





################################ TRUE OUTPUTS ############################
# explore:  fan_interest_prediction {}
view: fan_interest_prediction {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
          MODEL ${fan_interest_regression.SQL_TABLE_NAME},
          (SELECT * FROM ${fan_interest_input.SQL_TABLE_NAME}));;
  }

  dimension: predicted_total_visitors {
    type: number
  }

  dimension: residual {
    type:  number
    sql: ${predicted_total_visitors} - ${total_visitors}  ;;
  }
  dimension: residual_percent {
    type:  number
    value_format_name: percent_1
    sql: 1.0 * ${residual}/NULLIF(${total_visitors},0)  ;;
  }

  dimension: visitStart_date {
    type: date
    primary_key: yes
  }

  dimension: uk_average_temperature {
    type: number
  }

  dimension: humidity {
    type: number
  }
  dimension: total_visitors {
    type: number
  }
  measure: total_predicted_visitors {
    type: max
    sql: ${predicted_total_visitors} ;;
  }
  measure: overall_residual {
    type: max
    sql: ${residual} ;;
  }
  measure: overall_residual_percent {
    type: max
    value_format_name: percent_1
    sql: ${residual_percent} ;;
  }
}
