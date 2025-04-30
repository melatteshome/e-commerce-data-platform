-- models/marts/dim_customers.sql

{{ config(materialized='table') }}

SELECT
    customer_id,
    first_name,
    last_name,
    username,
    email,
    gender,
    birthdate,
    device_type,
    device_id,
    device_version,
    home_location_lat,
    home_location_long,
    home_location,
    home_country,
    first_join_date
FROM {{ ref('int_customer_deduplication') }}