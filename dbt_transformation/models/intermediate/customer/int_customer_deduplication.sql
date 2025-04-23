-- models/intermediate/int_customer_deduplication.sql

{{ config(materialized='view') }}

WITH ranked_customers AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY email, username
            ORDER BY first_join_date DESC
        ) AS row_num
    FROM {{ ref('stg_customers') }}
)

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
FROM ranked_customers
WHERE row_num = 1
