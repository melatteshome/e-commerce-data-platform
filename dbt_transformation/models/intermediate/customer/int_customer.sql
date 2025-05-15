{{config(materialized='view')}}

with base as(
    select * from {{ref('int_customer_deduplication')}}
),
enriched as (
    select 
    customer_id,
    concat_ws(' ', first_name , last_name) as full_name,
    username,
    email,
    gender,
    CAST(DATE_PART('year', AGE(CURRENT_DATE, birthdate) ) AS INTEGER) AS age,
    device_type,
    device_id,
    device_version,
    home_location_lat,
    home_location_long,
    home_location,
    home_country,
    first_join_date

    from base
)

select * from enriched