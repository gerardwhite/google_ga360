connection: "bq2look"

include: "*.view.lkml"         # include all views in this project


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
# Adds the explore for out of stock events

explore: view_pages_historical_allmarkets_ga {
  group_label: "GfK/Adobe"
  label: "Out of stock | All markets"

}
