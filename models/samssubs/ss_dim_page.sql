{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['page_url']) }} as page_key,
page_url
FROM {{ source('webtraffic_landing', 'web_traffic_events') }}