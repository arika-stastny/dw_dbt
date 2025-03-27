{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['p.productid']) }} as product_key,
p.productid,
productname, 
producttype,
productcalories,
length,
breadtype
FROM {{ source('subsales_landing', 'product') }} p
LEFT JOIN {{ source('subsales_landing', 'sandwich') }} s ON p.productid = s.productid