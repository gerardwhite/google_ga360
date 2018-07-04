view: code_snippets {
  derived_table: {
#     sql_trigger_value: select current_date ;;
    sql: SELECT
        CAST((TIMESTAMP((CAST(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)  AS DATE))))  AS DATE) AS ga_sessions_visitstart_date_1,
        COALESCE(SUM(totals.bounces ), 0) AS totals_bounces_total,
        COALESCE(SUM(totals.hits ), 0) AS totals_hits_total,
        COUNT(CASE WHEN (ga_sessions.visitnumber <> 1) THEN 1 ELSE NULL END) AS ga_sessions_returning_visitors
      FROM
                         `dyson-ga.19209080.ga_sessions_*`

                         AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals

      WHERE
        (((TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -30 DAY))) AND (TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -30 DAY), INTERVAL 30 DAY)))))
      GROUP BY 1
      ORDER BY 1 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ga_sessions_visitstart_date_1 {
    type: date
    sql: ${TABLE}.ga_sessions_visitstart_date_1 ;;
  }

  dimension: totals_bounces_total {
    type: number
    sql: ${TABLE}.totals_bounces_total ;;
  }

  dimension: totals_hits_total {
    type: number
    sql: ${TABLE}.totals_hits_total ;;
  }

  dimension: ga_sessions_returning_visitors {
    type: number
    sql: ${TABLE}.ga_sessions_returning_visitors ;;
  }

#counts days elapsed of 2018
  dimension: days_elapsed_2018 {
    type: number
    label: "By Day"
    sql:  date_diff(current_date(), date(2018,01,01), day)  ;;
  }


    # link: {
    #   label: "Website"
    #   url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
    #   icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
    # }

    # link: {
    #   label: "Facebook"
    #   url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
    #   icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
    # }


    #  GW: Code to LINK TO ANOTHER DASHBOARD (eg Global to Market)
    # link: {
    #   label: "{{value}} Analytics Dashboard"
    #   url: "/dashboards/8?Brand%20Name={{ value | encode_uri }}"
    #   icon_url: "http://www.looker.com/favicon.ico"
    # }




  #  GW: Code for an EMAIL DATA ACTION.

  #   action: {
  #     label: "Email Promotion to Customer"
  #     url: "https://desolate-refuge-53336.herokuapp.com/posts"
  #     icon_url: "https://sendgrid.com/favicon.ico"
  #     param: {
  #       name: "some_auth_code"
  #       value: "abc123456"
  #     }
  #     form_param: {
  #       name: "Subject"
  #       required: yes
  #       default: "Thank you {{ users.name._value }}"
  #     }
  #     form_param: {
  #       name: "Body"
  #       type: textarea
  #       required: yes
  #       default:
  #       "Dear {{ users.first_name._value }},

  #       Thanks for your loyalty to the Look.  We'd like to offer you a 10% discount
  #       on your next purchase!  Just use the code LOYAL when checking out!

  #       Your friends at the Look"
  #     }
  #   }
  #   required_fields: [name, first_name]
  # }


    #  GW: Code for a SLACK DATA ACTION.

    # action: {
    #   label: "Send this to slack channel"
    #   url: "https://hooks.zapier.com/hooks/catch/1662138/tvc3zj/"

    #   param: {
    #     name: "user_dash_link"
    #     value: "https://demo.looker.com/dashboards/160?Email={{ users.email._value}}"
    #   }

    #   form_param: {
    #     name: "Message"
    #     type: textarea
    #     default: "Hey,
    #     Could you check out order #{{value}}. It's saying its {{status._value}},
    #     but the customer is reaching out to us about it.
    #     ~{{ _user_attributes.first_name}}"
    #   }

    #   form_param: {
    #     name: "Recipient"
    #     type: select
    #     default: "zevl"
    #     option: {
    #       name: "zevl"
    #       label: "Zev"
    #     }
    #     option: {
    #       name: "slackdemo"
    #       label: "Slack Demo User"
    #     }

    #   }

    #   form_param: {
    #     name: "Channel"
    #     type: select
    #     default: "cs"
    #     option: {
    #       name: "cs"
    #       label: "Customer Support"
    #     }
    #     option: {
    #       name: "general"
    #       label: "General"
    #     }

    #   }


    # }

    # drill_fields: [category, item_name]


  set: detail {
    fields: [ga_sessions_visitstart_date_1, totals_bounces_total, totals_hits_total, ga_sessions_returning_visitors, days_elapsed_2018]
  }
}
