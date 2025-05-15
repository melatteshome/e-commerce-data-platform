-- models/staging/stg_customers.sql

{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('e-commerce', 'customer') }}
),

renamed AS (
    SELECT
        customer_id,
        INITCAP(first_name) AS first_name,
        INITCAP(last_name) AS last_name,
        LOWER(username) AS username,
        LOWER(email) AS email,
        CASE
            WHEN gender ILIKE 'm%' THEN 'Male'
            WHEN gender ILIKE 'f%' THEN 'Female'
            ELSE 'Other'
        END AS gender,
        CAST(birthdate AS DATE) AS birthdate,
        device_type,
        device_id,
        device_version,
        home_location_lat,
        home_location_long,
        home_location,
        home_country,
        CAST(first_join_date AS DATE) AS first_join_date
    FROM source
    WHERE email IS NOT NULL AND customer_id IS NOT NULL
)

SELECT * FROM renamed
