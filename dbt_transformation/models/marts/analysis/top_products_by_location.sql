{{config(materialized='table')}}

with tr as (
    select
        customer_id,
        product_id,
        quantity,
        quantity * item_price as revenue
        from {{ ref('int_transaction_exploded_products')}}
),

customer as (
    select 
        customer_id,
        home_location
    from {{ref('int_customer')}}
),
joined as (
    select
        tr.product_id,
        c.home_location,
        tr.quantity,
        tr.revenue
    from tr
    join customer c on tr.customer_id ::bigint = c.customer_id
),

agg as (
  select
    product_id,
    home_location,
    sum(quantity)      as total_quantity,
    sum(revenue)       as total_revenue
  from joined
  group by 1, 2
),

ranked as (
  select
    *,
    row_number() over (
      partition by home_location
      order by total_revenue desc
    ) as rn
  from agg
)

select
  product_id,
  home_location,
  total_quantity,
  total_revenue
from ranked
where rn = 1
order by home_location