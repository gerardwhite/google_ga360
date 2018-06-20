view: sql_runner_query_all_visits_by_dataset_id_test {
  derived_table: {
    sql: SELECT
        ao_lookertest1.dataset_id AS ao_lookertest1_dataset_id,
        SUM(ao_lookertest1.visits) AS visits,
      FROM ao_looker_test.ao_lookertest1 AS ao_lookertest1

      GROUP BY 1
      ORDER BY visits DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ao_lookertest1_dataset_id {
    type: string
    sql: ${TABLE}.ao_lookertest1_dataset_id ;;
  }

  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  set: detail {
    fields: [ao_lookertest1_dataset_id, visits]
  }
}
