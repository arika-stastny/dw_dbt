{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['event_name']) }} as event_key,
event_name
FROM {{ source('webtraffic_landing', 'web_traffic_events') }}