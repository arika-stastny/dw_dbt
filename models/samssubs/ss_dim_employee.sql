{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employee_key,
employeeid,
employeefname,
employeelname,
employeebday
FROM {{ source('subsales_landing', 'employee') }}