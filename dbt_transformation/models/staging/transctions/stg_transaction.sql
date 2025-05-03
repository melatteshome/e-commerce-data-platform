with source as (
    select * from {{source('e-commerce' , 'transactions')}}
),

renamed as(
    select
         cast(created_at as timestamp) as created_at,
        cast(customer_id as text) as customer_id,
        cast(booking_id as text) as booking_id,
        cast(session_id as text) as session_id,
        cast(product_metadata as text) as product_metadata,
        cast(payment_method as text) as payment_method,
        cast(payment_status as text) as payment_status,
        cast(promo_amount as numeric) as promo_amount,
        cast(promo_code as text) as promo_code,
        cast(shipment_fee as numeric) as shipment_fee,
        cast(shipment_date_limit as date) as shipment_date_limit,
        cast(shipment_location_lat as float) as shipment_location_lat,
        cast(shipment_location_long as float) as shipment_location_long,
        cast(total_amount as numeric) as total_amount
    from source
)

select * from renamed