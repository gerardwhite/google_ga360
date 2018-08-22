# Need to add unique purchases into data layer.

view: retail_all {
  derived_table: {
    datagroup_trigger: retail_datagroup
    sql: SELECT  Date as date
        ,DeviceName
        ,ItemDescription
        ,Quantity
        ,Gross
        ,Store
        ,Market
        ,Category
        ,Gross_GBP
        ,Currency_Code
        ,Unique_Code
        ,Store_Type
        ,Net_Rev1
        ,Net_Rev
        ,Week_and_Year
        ,Year
        ,Country
        ,null as Footfall
        ,'Retail' as source
FROM `dyson-ga.ao_looker_test.Retail` -- This is the retail sales table

UNION ALL

SELECT Date as date
      ,null as DeviceName
      ,null as ItemDescription
      ,null as Quantity
      ,null as Gross
      ,Store
      ,Market
      ,null as Category
      ,null as Gross_GBP
      ,null as Currency_Code
      ,null as Unique_Code
      ,Store_Type
      ,null as Net_Rev1
      ,null as Net_Rev
      ,null as Week_and_Year
      ,null as Year
      ,Country
      ,Footfall -- this number is DAILY for each country and channel
      ,'Footfall' as source
FROM  `dyson-ga.ao_looker_test.Footfall` --This  is the footfall table
 ;;
  }


  dimension_group: date {
    type: time
    timeframes: [year, month, quarter, date, week, week_of_year, day_of_week, day_of_month, month_name]
    sql: ${TABLE}.date ;;
    convert_tz: no
    datatype: date
  }


  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.Currency_Code ;;
  }

  dimension: device_name {
    type: string
    sql: ${TABLE}.DeviceName ;;
  }

  dimension: gross {
    type: number
    sql: ${TABLE}.Gross ;;
  }

  dimension: gross_gbp {
    type: number
    sql: ${TABLE}.Gross_GBP ;;
  }

  dimension: item_description {
    type: string
    sql: ${TABLE}.ItemDescription ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: net_rev {
    type: number
    sql: ${TABLE}.Net_Rev ;;
  }

  dimension: net_rev1 {
    type: number
    sql: ${TABLE}.Net_Rev1 ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension: store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  dimension: store_type {
    type: string
    sql: ${TABLE}.Store_Type ;;
  }

  dimension: unique_code {
    type: string
    sql: ${TABLE}.Unique_Code ;;
  }

  dimension: week_and_year {
    type: string
    sql: ${TABLE}.Week_and_Year ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  dimension: footfall {
    type: number
    sql: ${TABLE}.Footfall ;;
  }

  # AO: We don't have footfall recording for all stores
  measure: total_revenue {
    label: "Retail Sales"
    type: sum
    value_format_name: gbp_0
    sql: ${net_rev} ;;
  }

  measure: total_footfall  {
    type: sum
    sql: ${footfall} ;;
  }

  measure: transactions {
    type: sum
    sql: ${quantity} ;;
  }

  measure: footfall_conversion_rate {
    group_label: "Custom Retail measures"
    type: number
    sql: 1.0 * ((${transactions})/NULLIF(${total_footfall},0))  ;;
    value_format_name: percent_1
  }

  measure: value_per_footfall {
    group_label: "Custom Retail measures"
    type: number
    sql: ((${total_revenue})/NULLIF(${total_footfall},0))  ;;
    value_format_name: gbp_0
  }




  measure: count {
    type: count
    drill_fields: [device_name]
  }
}
