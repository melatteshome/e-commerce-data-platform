-- models/marts/mart_products.sql
{{ config(materialized='table') }}

with final as (

    select * 
    from {{ ref('int_product') }}

)

select
    product_id,
    product_display_name,
    gender,
    base_colour,
    season,
    product_full_category
from final
WHERE base_colour IS NOT NULL
  AND product_id IS NOT NULL
  AND gender IS NOT NULL
