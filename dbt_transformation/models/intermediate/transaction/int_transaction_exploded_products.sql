
with raw as (
  select
    booking_id as transaction_id,
    payment_method,
    payment_status, 
    REPLACE("product_metadata", '''','"')::jsonb as meta_json
  from {{ ref('stg_transaction') }}
),

exploded as (
  select
    transaction_id,
    payment_method,
    payment_status,
    (item ->> 'product_id')   ::int     as product_id,
    (item ->> 'quantity')     ::int     as quantity,
    (item ->> 'item_price')   ::numeric as item_price
  from raw
  cross join lateral
    jsonb_array_elements(raw.meta_json) as item
)

select * from exploded
