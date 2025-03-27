{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['ordernumber']) }} as order_key,
ordernumber, 
ordermethod
FROM {{ source('subsales_landing', 'orders') }}