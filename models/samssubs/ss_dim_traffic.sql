{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['traffic_source']) }} as traffic_key,
traffic_source
FROM {{ source('webtraffic_landing', 'web_traffic_events') }}