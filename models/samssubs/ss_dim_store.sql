{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['storeid']) }} as store_key,
storeid,
address,
city, 
state,
zip
FROM {{ source('subsales_landing', 'store') }}