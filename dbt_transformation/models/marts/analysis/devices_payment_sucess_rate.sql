{{config(materialized='table')}}

WITH customer AS(
    SELECT 
        customer_id,
        device_type,
        device_version
    from {{ref('mart_customers')}}

),

transactions AS (
    select 
        customer_id,
        payment_status,
        payment_method
    from {{ref('int_transaction_exploded_products')}}
),

joined AS(
    select
        c.customer_id,
        c.device_version,
        t.payment_status,
        t.payment_method
    from customer c
    join transactions t
        ON t.customer_id::bigint = c.customer_id

)

select 
    customer_id,
    device_version,
    payment_status,
    payment_method
from joined
where customer_id is not null