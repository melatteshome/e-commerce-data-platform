{{ config(materialized='table') }}

with "transaction" as (
    select * from {{ref('stg_transaction')}}
),

payments as (
    select * from {{ref('int_transaction')}}
),
final as (
    select
        o.customer_id,
        min(o.created_at) as first_order_date,
        max(o.created_at) as latest_order_date,
        count(distinct o.booking_id) as num_bookings,
        p.total_revenue,
        p.total_discount,
        p.total_shipment_fee
    from transaction o
    join payments p on o.customer_id = p.customer_id
    group by o.customer_id, p.total_revenue, p.total_discount, p.total_shipment_fee
)

select * from final
