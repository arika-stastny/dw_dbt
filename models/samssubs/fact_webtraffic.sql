{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
d.date_key,
p.page_key,
e.event_key,
t.traffic_key,
COUNT(*) as Activity
FROM {{ source('webtraffic_landing', 'web_traffic_events') }} w
INNER JOIN {{ref('ss_dim_date')}} d ON d.date_day = CAST(w.event_timestamp AS DATE)
INNER JOIN {{ref('ss_dim_event')}} e on e.event_name = w.event_name
INNER JOIN {{ref('ss_dim_page')}} p on p.page_url = w.page_url
INNER JOIN {{ref('ss_dim_traffic')}} t on t.traffic_source = w.traffic_source
GROUP BY d.date_key, p.page_key, e.event_key, t.traffic_key