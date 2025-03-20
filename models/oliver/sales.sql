
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

-- Based on the basic data given from Core 3
SELECT
CONCAT(c.first_name, ' ', c.last_name) AS Customer,
p.product_name, 
f.quantity,
f.unit_price,
CONCAT(e.first_name, ' ', e.last_name) AS Employee,
s.store_name,
d.date_key
FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key