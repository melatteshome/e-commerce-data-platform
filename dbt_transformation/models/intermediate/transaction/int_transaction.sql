with base as (
    select * from {{ ref('stg_transaction')}}
),

aggregated as (
    select
        customer_id,
        count(distinct booking_id) as total_bookings,
        sum(total_amount) as total_revenue,
        sum(promo_amount) as total_discount,
        sum(shipment_fee) as total_shipment_fee
    from base
    group by customer_id
)

select * from aggregated
