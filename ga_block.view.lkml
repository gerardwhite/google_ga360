explore: ga_sessions_base {
  persist_for: "1 hour"
  extension: required
  view_name: ga_sessions
  view_label: "Session"
  join: totals {
    view_label: "Session"
    sql: LEFT JOIN UNNEST([${ga_sessions.totals}]) as totals ;;
    relationship: one_to_one
  }
  join: trafficSource {
    view_label: "Session: Traffic Source"
    sql: LEFT JOIN UNNEST([${ga_sessions.trafficSource}]) as trafficSource ;;
    relationship: one_to_one
  }
  # join: adwordsClickInfo {
  #   view_label: "Session: Traffic Source : Adwords"
  #   sql: LEFT JOIN UNNEST([${trafficSource.adwordsClickInfo}]) as  adwordsClickInfo;;
  #   relationship: one_to_one
  # }

  # join: DoubleClickClickInfo {
  #   view_label: "Session: Traffic Source : DoubleClick"
  #   sql: LEFT JOIN UNNEST([${trafficSource.DoubleClickClickInfo}]) as  DoubleClickClickInfo;;
  #   relationship: one_to_one
  # }
  join: device {
    view_label: "Session: Device"
    sql: LEFT JOIN UNNEST([${ga_sessions.device}]) as device ;;
    relationship: one_to_one
  }
  join: geoNetwork {
    view_label: "Session: Geo Network"
    sql: LEFT JOIN UNNEST([${ga_sessions.geoNetwork}]) as geoNetwork ;;
    relationship: one_to_one
  }
  join: hits {
    view_label: "Session: Hits"
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) as hits ;;
    relationship: one_to_many
  }
  join: hits_page {
    view_label: "Session: Hits: Page"
    sql: LEFT JOIN UNNEST([${hits.page}]) as hits_page ;;
    relationship: one_to_one
  }
  join: hits_transaction {
    view_label: "Session: Hits: Transaction"
    sql: LEFT JOIN UNNEST([${hits.transaction}]) as hits_transaction ;;
    relationship: one_to_one
  }
  join: hits_item {
    view_label: "Session: Hits: Item"
    sql: LEFT JOIN UNNEST([${hits.item}]) as hits_item ;;
    relationship: one_to_one
  }
  join: hits_social {
    view_label: "Session: Hits: Social"
    sql: LEFT JOIN UNNEST([${hits.social}]) as hits_social ;;
    relationship: one_to_one
  }
  join: hits_publisher {
    view_label: "Session: Hits: Publisher"
    sql: LEFT JOIN UNNEST([${hits.publisher}]) as hits_publisher ;;
    relationship: one_to_one
  }
  join: hits_appInfo {
    view_label: "Session: Hits: App Info"
    sql: LEFT JOIN UNNEST([${hits.appInfo}]) as hits_appInfo ;;
    relationship: one_to_one
  }

  join: hits_eventInfo{
    view_label: "Session: Hits: Events Info"
    sql: LEFT JOIN UNNEST([${hits.eventInfo}]) as hits_eventInfo ;;
    relationship: one_to_one
  }

#   join: hits_sourcePropertyInfo {
#     view_label: "Session: Hits: Property"
#     sql: LEFT JOIN UNNEST([hits.sourcePropertyInfo]) as hits_sourcePropertyInfo ;;
#     relationship: one_to_one
#     required_joins: [hits]
#   }

  # join: hits_eCommerceAction {
  #   view_label: "Session: Hits: eCommerce"
  #   sql: LEFT JOIN UNNEST([hits.eCommerceAction]) as  hits_eCommerceAction;;
  #   relationship: one_to_one
  #   required_joins: [hits]
  # }

  join: hits_customDimensions {
    view_label: "Session: Hits: Custom Dimensions"
    sql: LEFT JOIN UNNEST(${hits.customDimensions}) as hits_customDimensions ;;
    relationship: one_to_many
  }
  join: hits_customVariables{
    view_label: "Session: Hits: Custom Variables"
    sql: LEFT JOIN UNNEST(${hits.customVariables}) as hits_customVariables ;;
    relationship: one_to_many
  }
  join: first_hit {
    from: hits
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) as first_hit ;;
    relationship: one_to_one
    sql_where: ${first_hit.hitNumber} = 1 ;;
    fields: [first_hit.page]
  }
  join: first_page {
    view_label: "Session: First Page Visited"
    from: hits_page
    sql: LEFT JOIN UNNEST([${first_hit.page}]) as first_page ;;
    relationship: one_to_one
  }
}

view: ga_sessions_base {
  extension: required
    dimension: partition_date {
      type: date_time
      sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ;;
    }

    dimension: id {
      primary_key: yes
      sql: CONCAT(CAST(${fullVisitorId} AS STRING), '|', COALESCE(CAST(${visitId} AS STRING),''), CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))   AS STRING)) ;;
    }

  dimension: visitorId {label: "Visitor ID"}

  dimension: visitnumber {
    label: "Visit Number"
    type: number
    description: "The session number for this user. If this is the first session, then this is set to 1."
  }

  dimension:  first_time_visitor {
    type: yesno
    sql: ${visitnumber} = 1 ;;
  }

  dimension: visitnumbertier {
    label: "Visit Number Tier"
    type: tier
    tiers: [1,2,5,10,15,20,50,100]
    style: integer
    sql: ${visitnumber} ;;
  }
  dimension: visitId {label: "Visit ID"}
  dimension: fullVisitorId {label: "Full Visitor ID"}

  dimension: visitStartSeconds {
    label: "Visit Start Seconds"
    type: date
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStarttime) ;;
    hidden: yes
  }

  ## referencing partition_date for demo purposes only. Switch this dimension to reference visistStartSeconds
  dimension_group: visitStart {
    timeframes: [date,day_of_week,fiscal_quarter,week,month,year,month_name,month_num,week_of_year]
    label: "Visit Start"
    type: time
    sql: (TIMESTAMP(${visitStartSeconds})) ;;
  }
  ## use visit or hit start time instead
  dimension: date {
    hidden: yes
  }
  dimension: socialEngagementType {label: "Social Engagement Type"}
  dimension: userid {label: "User ID"}

  measure: session_count {
    type: count
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.transactions_count, totals.transactionRevenue_total]
  }
  measure: unique_visitors {
    type: count_distinct
    sql: ${fullVisitorId} ;;
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
  }

  measure: average_sessions_ver_visitor {
    type: number
    sql: 1.0 * (${session_count}/NULLIF(${unique_visitors},0))  ;;
    value_format_name: decimal_2
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
  }






  measure: total_visitors {
    type: count
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
  }

  measure: number_of_organic_visitors {
    type: count
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
    group_label: "Total Visitor Types"
    filters: {
      field: channelGrouping
      value: "Organic Search"
    }
  }

  measure: percentage_of_organic_visitors {
    group_label: "Total Visitor Types"
    type: number
    sql: 1.0 * (${number_of_organic_visitors}/NULLIF(${total_visitors},0))  ;;
    value_format_name: percent_2
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
  }




## Added measures for last year week comparison. This is prob the easiest way to do it.
  measure: number_of_visitors_last_week_last_year {
    type: count
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
    group_label: "Total Visitor Types"
    filters: {
      field: visitStart_week
      value: "53 weeks ago"
    }
  }

  measure: number_of_visitors_last_week {
    type: count
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
    group_label: "Total Visitor Types"
    filters: {
      field: visitStart_week
      value: "last week"
    }
  }

  measure: visitors_last_week_vs_last_year{
    group_label: "Total Visitor Types"
    type: number
    sql: 1.0 * ((${number_of_visitors_last_week}-${number_of_visitors_last_week_last_year})/NULLIF(${number_of_visitors_last_week_last_year},0))  ;;
    value_format_name: percent_2
    drill_fields: [fullVisitorId, visitnumber, session_count, totals.hits, totals.page_views, totals.timeonsite]
  }





  dimension: reporting_year {
    group_label: "Order Date"
    sql: CASE
        WHEN extract(year from ${visitStart_date}) = extract( year from current_date())
        AND ${visitStart_date} < CURRENT_DATE()
        THEN 'This Year to Date'

        WHEN extract(year from ${visitStart_date}) + 1 = extract(year from current_date())
        AND extract(dayofyear from ${visitStart_date}) <= extract(dayofyear from current_date())
        THEN 'Last Year to Date'

      END
       ;;
  }

  measure: first_time_visitors {
    label: "First Time Visitors"
    type: count
    filters: {
      field: visitnumber
      value: "1"
    }
  }

  measure: second_time_visitors {
    label: "Second Time Visitors"
    type: count
    filters: {
      field: visitnumber
      value: "2"
    }
  }


  measure: returning_visitors {
    label: "Returning Visitors"
    type: count
    filters: {
      field: visitnumber
      value: "<> 1"
    }
  }

  dimension: channelGrouping {label: "Channel Grouping"}

  # subrecords
  dimension: geoNetwork {hidden: yes}
  dimension: totals {hidden:yes}
  dimension: trafficSource {hidden:yes}
  dimension: device {hidden:yes}
  dimension: customDimensions {hidden:yes}
  dimension: hits {hidden:yes}
  dimension: hits_eventInfo {hidden:yes}

}


view: geoNetwork_base {
  extension: required
  dimension: continent {
    drill_fields: [subcontinent,country,region,city,metro,approximate_networkLocation,networkLocation]
  }
  dimension: subcontinent {
    drill_fields: [country,region,city,metro,approximate_networkLocation,networkLocation]

  }
  dimension: country {
    map_layer_name: countries
    drill_fields: [region,metro,city,approximate_networkLocation,networkLocation]
  }
  dimension: region {
    drill_fields: [metro,city,approximate_networkLocation,networkLocation]
  }
  dimension: metro {
    drill_fields: [city,approximate_networkLocation,networkLocation]
  }
  dimension: city {drill_fields: [metro,approximate_networkLocation,networkLocation]}
  dimension: cityid { label: "City ID"}
  dimension: networkDomain {label: "Network Domain"}
  dimension: latitude {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.latitude as FLOAT64);;
  }
  dimension: longitude {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.longitude as FLOAT64);;
  }
  dimension: networkLocation {label: "Network Location"}
  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
  dimension: approximate_networkLocation {
    type: location
    sql_latitude: ROUND(${latitude},1) ;;
    sql_longitude: ROUND(${longitude},1) ;;
    drill_fields: [networkLocation]
  }
}


view: totals_base {
  extension: required
  dimension: id {
    primary_key: yes
    hidden: yes
    sql: ${ga_sessions.id} ;;
  }
  measure: visits_total {
    type: sum
    sql: ${TABLE}.visits ;;
  }
  measure: hits_total {
    type: sum
    sql: ${TABLE}.hits ;;
    drill_fields: [hits.detail*]
  }
  measure: hits_average_per_session {
    type: number
    sql: 1.0 * ${hits_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: decimal_2
  }
  measure: pageviews_total {
    label: "Page Views"
    type: sum
    sql: ${TABLE}.pageviews ;;
  }
  measure: timeonsite_total {
    label: "Time On Site"
    type: sum
    sql: ${TABLE}.timeonsite ;;
  }
  dimension: timeonsite_tier {
    label: "Time On Site Tier"
    type: tier
    sql: ${TABLE}.timeonsite ;;
    tiers: [0,15,30,60,120,180,240,300,600]
    style: integer
  }
  measure: timeonsite_average_per_session {
    label: "Time On Site Average Per Session"
    type: number
    sql: 1.0 * ${timeonsite_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: decimal_2
  }

  measure: page_views_session {
    label: "PageViews Per Session"
    type: number
    sql: 1.0 * ${pageviews_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: decimal_2
  }

  measure: bounces_total {
    type: sum
    sql: ${TABLE}.bounces ;;
  }


  #  REDS AND GREENS

  measure: bounces_total_rg {
    view_label: "🚥 Reds and Greens 🚥"
    label: "Bounces Total"
    type: sum
    sql: ${TABLE}.bounces ;;
    html:
    {% if value <= 20 %}
    <div style="color: white; background-color: darkred; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% elsif value <= 50 %}
    <div style="color: black; background-color: goldenrod; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% else %}
    <div style="color: white; background-color: darkgreen; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% endif %} ;;
  }

  measure: bounce_rate_rg {
    view_label: "🚥 Reds and Greens 🚥"
    label: "Bounce Rate"
    type:  number
    sql: 1.0 * ${bounces_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: percent_2
    html:
    {% if value <= 20 %}
    <div style="color: white; background-color: darkred; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% elsif value <= 50 %}
    <div style="color: black; background-color: goldenrod; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% else %}
    <div style="color: white; background-color: darkgreen; font-size: 100%; text-align:center">{{ rendered_value }}</div>
    {% endif %} ;;
  }

  measure: bounce_rate {
    type:  number
    sql: 1.0 * ${bounces_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: percent_2

  }


#   measure: bounce_rate_plus {
#     type:  number
#     description: "Use this for Germany. See Alex for more."
#     view_label: "Dyson Special KPIs"
#     sql: ${bounce_rate} + 10;;
#     value_format_name: percent_2
#   }

  measure: transactions_count {
    type: sum
    sql: ${TABLE}.transactions ;;
  }

  measure: transactionRevenue_total {
    description: "This is in the local currency"
    label: "Transaction Revenue Total (local)"
    type: sum
    sql: (${TABLE}.transactionRevenue/1000000) ;;
    value_format_name: decimal_1
    drill_fields: [transactions_count, transactionRevenue_total]
  }

  measure: transactionRevenue_total_gbp {
    description: "This is in GBP"
    label: "Transaction Revenue Total (£)"
    value_format_name: gbp_0
    type: sum
    sql: (${TABLE}.transactionRevenue/1000000) / ${tax_xrates_by_country_2018_v2.xrate} ;;
    drill_fields: [transactions_count, transactionRevenue_total]
  }



  measure: newVisits_total {
    label: "New Visits Total"
    type: sum
    sql: ${TABLE}.newVisits ;;
  }
  measure: screenViews_total {
    label: "Screen Views Total"
    type: sum
    sql: ${TABLE}.screenViews ;;
  }
  measure: timeOnScreen_total{
    label: "Time On Screen Total"
    type: sum
    sql: ${TABLE}.timeOnScreen ;;
  }
  measure: uniqueScreenViews_total {
    label: "Unique Screen Views Total"
    type: sum
    sql: ${TABLE}.uniqueScreenViews ;;
  }
  dimension: timeOnScreen_total_unique{
    label: "Time On Screen Total"
    type: number
    sql: ${TABLE}.timeOnScreen ;;
  }

  # Required calculated fields
# Average order value (AOV)

measure: average_order_value {
  value_format_name: decimal_2
  type: average
  sql: (${TABLE}.transactionRevenue/1000000) ;;
  }



measure: value_per_session {
  value_format_name: decimal_2
  type: number
  sql: ${transactionRevenue_total} / ${ga_sessions.session_count} ;;
}


  measure: average_order_value_gbp {
    value_format_name: gbp
    type: average
    sql: (${TABLE}.transactionRevenue/1000000)/${tax_xrates_by_country_2018_v2.xrate} ;;
  }




  measure: value_per_session_gbp {
    value_format_name: gbp
    type: number
    sql: ${transactionRevenue_total_gbp} / ${ga_sessions.session_count} ;;
  }

# 'Segment data' for example shop visits

measure: conversion_rate {
  value_format_name: percent_2
  type: number
  description: "Transactions / Sessions"
  sql: ${transactions_count}/${ga_sessions.session_count}  ;;
}
}


view: trafficSource_base {
  extension: required

  dimension: addContent {}
#   dimension: adwords {}
  dimension: referralPath {label: "Referral Path"}
  dimension: campaign {}
  dimension: source {}
  dimension: medium {}
  dimension: keyword {
    link: {
      label: "Pause Ad Group"
      icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
      url: "https://adwords.google.com/"
    }
    link: {
      url: "https://adwords.google.com/"
      icon_url: "https://www.gstatic.com/awn/awsm/brt/awn_awsm_20171108_RC00/aw_blend/favicon.ico"
      label: "Change Bid"
    }
  }
  dimension: adContent {label: "Ad Content"}
  measure: source_list {
    type: list
    list_field: source
  }
  measure: source_count {
    type: count_distinct
    sql: ${source} ;;
    drill_fields: [source, totals.hits, totals.pageviews]
  }
  measure: keyword_count {
    type: count_distinct
    sql: ${keyword} ;;
    drill_fields: [keyword, totals.hits, totals.pageviews]
  }
  # Subrecords
#   dimension: adwordsClickInfo {}
}

view: adwordsClickInfo_base {
  extension: required
  dimension: campaignId {label: "Campaign ID"}
  dimension: adGroupId {label: "Ad Group ID"}
  dimension: creativeId {label: "Creative ID"}
  dimension: criteriaId {label: "Criteria ID"}
  dimension: page {type: number}
  dimension: slot {}
  dimension: criteriaParameters {label: "Criteria Parameters"}
  dimension: gclId {}
  dimension: customerId {label: "Customer ID"}
  dimension: adNetworkType {label: "Ad Network Type"}
  dimension: targetingCriteria {label: "Targeting Criteria"}
  dimension: isVideoAd {
    label: "Is Video Ad"
    type: yesno
  }
}

view: device_base {
  extension: required

  dimension: browser {}
  dimension: browserVersion {label:"Browser Version"}
  dimension: operatingSystem {label: "Operating System"}
  dimension: operatingSystemVersion {label: "Operating System Version"}
  dimension: isMobile {label: "Is Mobile" type: yesno}
  dimension: deviceCategory {label: "Device Category"}
  dimension: flashVersion {label: "Flash Version"}
  dimension: javaEnabled {
    label: "Java Enabled"
    type: yesno
  }
  dimension: language {}
  dimension: screenColors {label: "Screen Colors"}
  dimension: screenResolution {label: "Screen Resolution"}
  dimension: mobileDeviceBranding {label: "Mobile Device Branding"}
  dimension: mobileDeviceInfo {label: "Mobile Device Info"}
  dimension: mobileDeviceMarketingName {label: "Mobile Device Marketing Name"}
  dimension: mobileDeviceModel {label: "Mobile Device Model"}
  dimension: mobileDeviceInputSelector {label: "Mobile Device Input Selector"}
}

view: hits_base {
  extension: required
  dimension: id {
    primary_key: yes
    sql: CONCAT(${ga_sessions.id},'|',FORMAT('%05d',${hitNumber})) ;;
  }
  dimension: hitNumber {}
  dimension: time {}
  dimension_group: hit {
    timeframes: [date,day_of_week,fiscal_quarter,week,month,year,month_name,month_num,week_of_year]
    type: time
    sql: TIMESTAMP_MILLIS(${ga_sessions.visitStartSeconds}*1000 + ${TABLE}.time) ;;
  }
  dimension: hour {}
  dimension: minute {}
  dimension: isSecure {
    label: "Is Secure"
    type: yesno
  }
  dimension: isiInteraction {
    label: "Is Interaction"
    type: yesno
  }
  dimension: referer {}

  measure: count {
    type: count
    drill_fields: [hits.detail*]
  }

  # subrecords
  dimension: page {hidden:yes}
  dimension: transaction {hidden:yes}
  dimension: item {hidden:yes}
  dimension: contentinfo {hidden:yes}
  dimension: social {hidden: yes}
  dimension: publisher {hidden: yes}
  dimension: appInfo {hidden: yes}
  dimension: contentInfo {hidden: yes}
  dimension: customDimensions {hidden: yes}
  dimension: customMetrics {hidden: yes}
  dimension: customVariables {hidden: yes}
  dimension: ecommerceAction {hidden: yes}
  dimension: eventInfo {hidden:yes}
  dimension: exceptionInfo {hidden: yes}
  dimension: experiment {hidden: yes}


  set: detail {
    fields: [ga_sessions.id, ga_sessions.visitnumber, ga_sessions.session_count, hits_page.pagePath, hits.pageTitle]
  }
}

view: hits_page_base {
  extension: required
  dimension: pagePath {
    label: "Page Path"
    link: {
      label: "Link"
      url: "{{ value }}"
    }
    link: {
      label: "Page Info Dashboard"
      url: "/dashboards/101?Page%20Path={{ value | encode_uri}}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }
  dimension: hostName {label: "Host Name"}
  dimension: pageTitle {label: "Page Title"

   link: {
      label: "View Page"

      url: "http://{{ ga_sessions.website_selector._value}}{{ pagePath }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/dyson-fav.ico"
    }

    link: {
      url: "https://adwords.google.com/"
      icon_url: "https://www.gstatic.com/awn/awsm/brt/awn_awsm_20171108_RC00/aw_blend/favicon.ico"
      label: "Modify Adgroups"
    }


    action: {
          label: "Email web team"
          url: "https://nonononono"
          icon_url: "https://sendgrid.com/favicon.ico"
          param: {
            name: "some_auth_code"
            value: "abc123456"
          }
          form_param: {
            name: "Subject"
            required: yes
            default: "Page issue: Please check: {{ pageTitle }}"
          }
          form_param: {
            name: "Body"
            type: textarea
            required: yes
            default:
            "ALERT

            Page {{ pageTitle }} is down, on URL {{ pagePath }}

            See this link for more detail

            ~{{ _user_attributes.first_name}}"
          }
        }
        # required_fields: [name, first_name]
      }





  dimension: searchKeyword {label: "Search Keyword"

    link: {
      label: "Trends for: {{searchKeyword._value}}"
      icon_url: "https://www.google.com/s2/favicons?domain=https://trends.google.com"
      url: "https://trends.google.com/trends/explore?geo=FR&q={{ searchKeyword._value | encode_uri }}"
    }

    link: {
      label: "Pause Ad Group"
      icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
      url: "https://adwords.google.com/"
    }
    link: {
      url: "https://adwords.google.com/"
      icon_url: "https://www.gstatic.com/awn/awsm/brt/awn_awsm_20171108_RC00/aw_blend/favicon.ico"
      label: "Change Bid"
    }
    }
  dimension: searchCategory{label: "Search Category"}
}

view: hits_transaction_base {
  extension: required

  dimension: id {
    primary_key: yes
    sql: ${hits.id} ;;
  }
  dimension: transactionShipping {label: "Transaction Shipping"}
  dimension: affiliation {}
  dimension: currencyCode {label: "Currency Code"}
  dimension: localTransactionRevenue {label: "Local Transaction Revenue"}
  dimension: localTransactionTax {label: "Local Transaction Tax"}
  dimension: localTransactionShipping {label: "Local Transaction Shipping"}
}

view: hits_item_base {
  extension: required

  dimension: id {
    primary_key: yes
    sql: ${hits.id} ;;
  }
  dimension: transactionId {label: "Transaction ID"}
  dimension: productName {
    label: "Product Name"
    }

  dimension: productCategory {label: "Product Catetory"}
  dimension: productSku {label: "Product Sku"}

  dimension: itemQuantity {
    description: "Should only be used as a dimension"
    label: "Item Quantity"
    hidden: yes
    }
  dimension: itemRevenue {
    description: "Should only be used as a dimension"
    label: "Item Revenue"
    hidden: yes
    }
  dimension: curencyCode {label: "Curency Code"}
  dimension: localItemRevenue {
    label:"Local Item Revenue"
    description: "Should only be used as a dimension"
    }

  measure: product_count {
    type: count_distinct
    sql: ${productSku} ;;
    drill_fields: [productName, productCategory, productSku, total_item_revenue]
  }
}

view: hits_social_base {
  extension: required   ## THESE FIELDS WILL ONLY BE AVAILABLE IF VIEW "hits_social" IN GA CUSTOMIZE HAS THE "extends" parameter declared

  dimension: socialInteractionNetwork {label: "Social Interaction Network"}
  dimension: socialInteractionAction {label: "Social Interaction Action"}
  dimension: socialInteractions {label: "Social Interactions"}
  dimension: socialInteractionTarget {label: "Social Interaction Target"}
  dimension: socialNetwork {label: "Social Network"}
  dimension: uniqueSocialInteractions {
    label: "Unique Social Interactions"
    type: number
  }
  dimension: hasSocialSourceReferral {label: "Has Social Source Referral"}
  dimension: socialInteractionNetworkAction {label: "Social Interaction Network Action"}
}

view: hits_publisher_base {
  extension: required    ## THESE FIELDS WILL ONLY BE AVAILABLE IF VIEW "hits_publisher" IN GA CUSTOMIZE HAS THE "extends" parameter declared

  dimension: dfpClicks {}
  dimension: dfpImpressions {}
  dimension: dfpMatchedQueries {}
  dimension: dfpMeasurableImpressions {}
  dimension: dfpQueries {}
  dimension: dfpRevenueCpm {}
  dimension: dfpRevenueCpc {}
  dimension: dfpViewableImpressions {}
  dimension: dfpPagesViewed {}
  dimension: adsenseBackfillDfpClicks {}
  dimension: adsenseBackfillDfpImpressions {}
  dimension: adsenseBackfillDfpMatchedQueries {}
  dimension: adsenseBackfillDfpMeasurableImpressions {}
  dimension: adsenseBackfillDfpQueries {}
  dimension: adsenseBackfillDfpRevenueCpm {}
  dimension: adsenseBackfillDfpRevenueCpc {}
  dimension: adsenseBackfillDfpViewableImpressions {}
  dimension: adsenseBackfillDfpPagesViewed {}
  dimension: adxBackfillDfpClicks {}
  dimension: adxBackfillDfpImpressions {}
  dimension: adxBackfillDfpMatchedQueries {}
  dimension: adxBackfillDfpMeasurableImpressions {}
  dimension: adxBackfillDfpQueries {}
  dimension: adxBackfillDfpRevenueCpm {}
  dimension: adxBackfillDfpRevenueCpc {}
  dimension: adxBackfillDfpViewableImpressions {}
  dimension: adxBackfillDfpPagesViewed {}
  dimension: adxClicks {}
  dimension: adxImpressions {}
  dimension: adxMatchedQueries {}
  dimension: adxMeasurableImpressions {}
  dimension: adxQueries {}
  dimension: adxRevenue {}
  dimension: adxViewableImpressions {}
  dimension: adxPagesViewed {}
  dimension: adsViewed {}
  dimension: adsUnitsViewed {}
  dimension: adsUnitsMatched {}
  dimension: viewableAdsViewed {}
  dimension: measurableAdsViewed {}
  dimension: adsPagesViewed {}
  dimension: adsClicked {}
  dimension: adsRevenue {}
  dimension: dfpAdGroup {}
  dimension: dfpAdUnits {}
  dimension: dfpNetworkId {}
}

view: hits_appInfo_base {
  extension: required

  dimension: name {}
  dimension: version {}
  dimension: id {}
  dimension: installerId {}
  dimension: appInstallerId {}
  dimension: appName {}
  dimension: appVersion {}
  dimension: appId {}
  dimension: screenName {}
  dimension: landingScreenName {}
  dimension: exitScreenName {}
  dimension: screenDepth {}
}

view: contentInfo_base {
  extension: required
  dimension: contentDescription {}
}

view: hits_customDimensions_base {
  extension: required
  dimension: index {type:number}
  dimension: value {}
}

view: hits_customMetrics_base {
  extension: required

  dimension: index {type:number}
  dimension: value {}
}

view: hits_customVariables_base {
  extension: required
  dimension: customVarName {}
  dimension: customVarValue {}
  dimension: index {type:number}
}

view: hits_eCommerceAction_base {
  extension: required
  dimension: action_type {}
  dimension: option {}
  dimension: step {}
}

view: hits_eventInfo_base {
  extension: required
  dimension: eventCategory {label: "Event Category"}

  dimension: eventAction {label: "Event Action"}
  dimension: eventLabel {label: "Event Label"}
  dimension: eventValue {label: "Event Category"}

}

# view: hits_sourcePropertyInfo {
# #   extension: required
#   dimension: sourcePropertyDisplayName {label: "Property Display Name"}
# }
