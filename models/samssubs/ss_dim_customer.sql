{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_key,
customerid, 
customerfname,
customerlname,
customerbday,
customerphone
FROM {{ source('subsales_landing', 'customer') }}