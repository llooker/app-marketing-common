view: date_base {
  extension: required

  dimension_group: date {
    group_label: "Event"
    label: ""
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year
    ]
    convert_tz: no
    sql: ${_date} ;;
  }

  dimension: date_week_date {
    group_label: "Event"
    label: "Week Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: CAST(${date_week} AS DATE) ;;
#     expression: to_date(${date_week}) ;;
  }

  dimension: date_month_date {
    group_label: "Event"
    label: "Month Date"
    hidden: yes
    type: date
    convert_tz: no
    sql:
      {% if _dialect._name == 'redshift' %}
        DATETRUNC(${date_date}, MONTH)
      {% else %}
        DATE_TRUNC(MONTH, ${date_date})
      {% endif %}
    ;;
#     expression: trunc_months(${date_date});;
  }

  dimension: date_quarter_date {
    group_label: "Event"
    label: "Quarter Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
        DATETRUNC(QUARTER, ${date_date})
      {% else %}
        DATE_TRUNC(${date_date}, QUARTER)
      {% endif %} ;;
#     expression: trunc_quarters(${date_date});;
  }

  dimension: date_year_date {
    group_label: "Event"
    label: "Year Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
        DATETRUNC(YEAR, ${date_date})
        {% else %}
        DATE_TRUNC(${date_date}, YEAR)
      {% endif %}  ;;
#     expression: trunc_years(${date_date}) ;;
  }

  dimension: date_day_of_quarter {
    group_label: "Event"
    label: "Day of Quarter"
    hidden: yes
    type: number
    sql: {% if _dialect._name == 'redshift' %}
        DATEDIFF(day, ${date_date}, ${date_quarter_date})
        {% else %}
        DATE_DIFF(${date_date}, ${date_quarter_date}, day)
      {% endif %}  ;;
#     expression: diff_days(${date_quarter_date}, ${date_date}) ;;
  }

  dimension: date_last_week {
    group_label: "Event"
    label: "Last Week"
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
        DATEADD(week, -1, ${date_quarter_date})
        {% else %}
        DATE_ADD(${date_date}), INTERVAL -1 WEEK)
      {% endif %} ;;
#     expression: add_days(${date_date}, 7) ;;
  }

  dimension: date_last_month {
    group_label: "Event"
    label: "Last Month"
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
        DATEADD(month, -1, ${date_date})
        {% else %}
        DATE_ADD(${date_date}), INTERVAL -1 MONTH)
      {% endif %} ;;
#     expression: add_months(${date_date}, 1) ;;
  }

  dimension: date_last_quarter {
    group_label: "Event"
    label: "Last Quarter"
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
        DATEADD(quarter, -1, ${date_date})
        {% else %}
        DATE_ADD(${date_date}), INTERVAL -1 QUARTER)
        {% endif %} ;;
#     expression: add_months(${date_date}, -3) ;;
  }

  dimension: date_next_week {
    hidden: yes
    type: date
    convert_tz: no
    sql:  {% if _dialect._name == 'redshift' %}
          DATEADD(week, 1, ${date_date})
          {% else %}
          DATE_ADD(${date_date}), INTERVAL 1 WEEK)
          {% endif %} ;;
#     expression: add_days(${date_date}, 7) ;;
  }

  dimension: date_next_month {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(month, 1, ${date_date})
          {% else %}
          DATE_ADD(${date_date}), INTERVAL 1 MONTH)
          {% endif %}  ;;
#     expression: add_months(${date_date}, 1) ;;
  }

  dimension: date_next_quarter {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(quarter, 1, ${date_date})
          {% else %}
          DATE_ADD(${date_date}), INTERVAL 1 QUARTER)
          {% endif %}  ;;
#     expression: add_months(${date_date}, 3) ;;
  }

  dimension: date_next_year {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(year, 1, ${date_date})
          {% else %}
          DATE_ADD(${date_date}), INTERVAL 1 YEAR)
          {% endif %}  ;;
#     expression: add_years(${date_date}, 1) ;;
  }

  dimension: date_last_year {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(year, -1, ${date_date})
          {% else %}
          DATE_ADD(${date_date}), INTERVAL -1 YEAR)
          {% endif %}  ;;
#     expression: add_years(${date_date}, -1) ;;
  }

  dimension: date_days_prior {
    hidden: yes
    type: number
    sql: {% if _dialect._name == 'redshift' %}
          DATEDIFF(day, ${date_date}, CURRENT_DATE)
        {% else %}
          DATE_DIFF(${date_date}, CURRENT_DATE(), DAY)
        {% endif %}  ;;
#     expression: diff_days(${date_date}, now()) ;;
  }

  dimension: date_day_of_7_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 7) + 7, 7) ;;
#     expression: mod(mod(${date_days_prior}, 7) + 7, 7) ;;
  }

  dimension: date_day_of_28_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 28) + 28, 28) ;;
#     expression: mod(mod(${date_days_prior}, 28) + 28, 28) ;;
  }

  dimension: date_day_of_91_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 91) + 91, 91) ;;
#     expression: mod(mod(${date_days_prior}, 91) + 91, 91) ;;
  }

  dimension: date_day_of_364_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 364) + 364, 364) ;;
#     expression: mod(mod(${date_days_prior}, 364) + 364, 364) ;;
  }

  dimension: date_date_7_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(day, -${date_day_of_7_days_prior}, ${date_date})
        {% else %}
          DATE_ADD(${date_date}, INTERVAL -${date_day_of_7_days_prior} DAY)
        {% endif %} ;;
#     expression: add_days(-1 * ${date_day_of_7_days_prior}, ${date_date}) ;;
  }

  dimension: date_date_28_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(day, -${date_day_of_28_days_prior}, ${date_date})
        {% else %}
          DATE_ADD(${date_date}, INTERVAL -${date_day_of_28_days_prior} DAY)
        {% endif %} ;;
#     expression: add_days(-1 * ${date_day_of_28_days_prior}, ${date_date}) ;;
  }

  dimension: date_date_91_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(day, -${date_day_of_91_days_prior}, ${date_date})
        {% else %}
          DATE_ADD(${date_date}, INTERVAL -${date_day_of_91_days_prior} DAY)
        {% endif %} ;;
#     expression: add_days(-1 * ${date_day_of_91_days_prior}, ${date_date}) ;;
  }

  dimension: date_date_364_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% if _dialect._name == 'redshift' %}
          DATEADD(day, -${date_day_of_364_days_prior}, ${date_date})
        {% else %}
          DATE_ADD(${date_date}, INTERVAL -${date_day_of_364_days_prior} DAY)
        {% endif %} ;;
#     expression: add_days(-1 * ${date_day_of_364_days_prior}, ${date_date}) ;;
  }

}
