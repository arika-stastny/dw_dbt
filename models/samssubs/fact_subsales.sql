{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
c.customer_key,
p.product_key,
od.order_key,
s.store_key,
e.employee_key,
d.date_key,
orderlineqty AS "Quantity",
orderlineprice AS "UnitPrice",
orderlineqty * orderlineprice AS "LineTotal",
pointsearned
FROM {{ source('subsales_landing', 'orderdetails') }} ods
INNER JOIN {{ source('subsales_landing', 'orders') }} o ON o.ordernumber = ods.ordernumber
INNER JOIN {{ref("ss_dim_date")}} d ON o.orderdate = d.date_day
INNER JOIN {{ref("ss_dim_customer")}} c ON c.customerid = o.customerid
INNER JOIN {{ref("ss_dim_employee")}} e ON e.employeeid = o.employeeid
INNER JOIN {{ref("ss_dim_order")}} od ON od.ordernumber = o.ordernumber
INNER JOIN {{ref("ss_dim_product")}} p ON p.productid = ods.productid
INNER JOIN {{source('subsales_landing', 'employee')}} em ON em.employeeid = e.employeeid
INNER JOIN {{ref("ss_dim_store")}} s ON s.storeid = em.storeid
