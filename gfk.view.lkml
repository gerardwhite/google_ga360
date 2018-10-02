view: gfk {
  sql_table_name: ao_looker_test.gfk ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }


  dimension: currency {
    type: string
    sql: ${TABLE}.Currency ;;
  }

  dimension_group: date_collected {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date_Collected ;;
  }

  dimension: dyson_category {
    type: string
    sql: ${TABLE}.Dyson_Category ;;
  }

  dimension: dyson_sku {
    type: string
    sql: ${TABLE}.Dyson_SKU ;;


    # Link to SKU level report
    link: {
      label: "Report for SKU: {{gfk.dyson_sku._value}}"
      url: "/dashboards/54?dyson_sku={{ gfk.dyson_sku._value | encode_uri }}"
      icon_url: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1615306/dyson-fav.ico"
    }
  }




  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.Price ;;
  }

  #Pricing measures
  measure: avg_price {
    type: average
    value_format_name: decimal_2
    sql: ${price}  ;;
  }



  measure: min_price {
    type: min
    sql: ${price}  ;;
  }

  measure: max_price {
    type: max
    sql: ${price}  ;;
  }
  ##

  dimension: promotion {
    type: string
    sql: ${TABLE}.Promotion ;;
  }

  dimension: retailer_name {
    type: string
    sql: ${TABLE}.Retailer_Name ;;

    # Link to SKU level report
    link: {
      label: "View product on retailer's website: {{gfk.retailer_name._value}}"
      url: "{{ retailer_url}}"
      icon_url: "{{retailer_favicon}}"
    }
  }


  dimension: retailer_favicon {
    type:  string
    sql:  CASE WHEN ${retailer_name} = "Amazon (FR)" THEN "https://www.google.com/s2/favicons?domain=www.amazon.fr"
             WHEN ${retailer_name} = "Auchan" THEN "https://www.google.com/s2/favicons?domain=https://www.auchan.fr/"
             WHEN ${retailer_name} = "Boulanger" THEN "https://www.google.com/s2/favicons?domain=https://www.boulanger.com/"
            WHEN ${retailer_name} = "BUT" THEN "https://www.google.com/s2/favicons?domain=https://www.but.fr/"
            WHEN ${retailer_name} = "Conforama" THEN "https://www.google.com/s2/favicons?domain=https://www.conforama.fr/"
            WHEN ${retailer_name} = "Darty" THEN "https://www.google.com/s2/favicons?domain=https://www.darty.com/"
            WHEN ${retailer_name} = "Dyson (FR)" THEN "https://www.google.com/s2/favicons?domain=https://www.dyson.fr"
            WHEN ${retailer_name} = "La Redoute" THEN "https://www.google.com/s2/favicons?domain=https://www.laredoute.co.uk"
            WHEN ${retailer_name} = "Rue du commerce" THEN "https://www.google.com/s2/favicons?domain=https://www.rueducommerce.fr/"
            WHEN ${retailer_name} = "Ubaldi" THEN "https://www.google.com/s2/favicons?domain=http://www.ubaldi.com"
  ELSE NULL
  END;;

    }



# This should be done dynamically using GFK URL data. Dyson added in.

    dimension: retailer_url {
      type:  string
      sql:  CASE WHEN ${retailer_name} = "Amazon (FR)" THEN "https://www.amazon.fr/s/ref=nb_sb_noss_1/261-6110857-7367250?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&url=search-alias%3Daps&field-keywords=am07"
             WHEN ${retailer_name} = "Auchan" THEN "https://www.auchan.fr/dyson-rafraichisseur-d-air-am07-cool-black-tour/p-m1809504"
             WHEN ${retailer_name} = "Boulanger" THEN "https://www.boulanger.com/ref/1020444"
            WHEN ${retailer_name} = "BUT" THEN "https://www.but.fr/produits/85220/Ventilateur-de-table-DYSON-AM06-Soft-touch.html"
            WHEN ${retailer_name} = "Conforama" THEN "https://www.google.com/s2/favicons?domain=https://www.conforama.fr/"
            WHEN ${retailer_name} = "Darty" THEN "https://www.google.com/s2/favicons?domain=https://www.darty.com/"
            WHEN ${retailer_name} = "Dyson (FR)" THEN "https://shop.dyson.fr/catalogsearch/result/?q=am07"
            WHEN ${retailer_name} = "La Redoute" THEN "https://www.laredoute.fr/ppdp/prod-500647308.aspx"
            WHEN ${retailer_name} = "Rue du commerce" THEN "https://www.google.com/s2/favicons?domain=https://www.rueducommerce.fr/"
            WHEN ${retailer_name} = "Ubaldi" THEN "https://www.google.com/s2/favicons?domain=http://www.ubaldi.com"
  ELSE NULL
  END;;

      }



      dimension: stock {
        type: yesno
        sql: ${TABLE}.Stock ;;
      }

      dimension: url {
        type: string
        sql: ${TABLE}.URL ;;
      }


# Retailer specific pricing:

      measure: amazon_price_France {
        group_label: "Retailer prices"
        type: average
        sql: ${price} ;;
        filters: {
          field: retailer_name
          value: "Amazon (FR)"
        }
      }

      measure: auchan_price_France {
        group_label: "Retailer prices"
        type: average
        sql: ${price} ;;
        filters: {
          field: retailer_name
          value: "Auchan"
        }
      }

      measure: boulanger_price_France {
        group_label: "Retailer prices"
        type: average
        sql: ${price} ;;
        filters: {
          field: retailer_name
          value: "Boulanger"
        }
      }


      measure: dyson_price {
        group_label: "Retailer prices"
        type: average
        sql: ${price} ;;
        filters: {
          field: retailer_name
          value: "Dyson (FR)"
        }
      }





#Removing the http|http from url.
      dimension: url_short {
        type: string
        sql: regexp_replace(${url}, '^http://|^https://', '')    ;;
      }





#Creates a substring on the URL so we can join in our pages tables. This needs work as it doesn't handle HTTP AND HTTPS.
      dimension: url_shortened {
        type: string
        sql: SUBSTR(${url}, 9)  ;;
      }


      dimension: dyson_image {
        type: string
        sql: ${dyson_sku};;
        html: <img src="https://dyson-h.assetsadobe2.com/is/image/content/dam/dyson/images/products/primary/{{value}}.png" /> ;;
      }





      measure: count {
        type: count
        drill_fields: [retailer_name, name]
      }
    }
