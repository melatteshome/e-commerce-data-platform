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
    product_full_category,
    year_time
from final
where base_colour is not null AND product_id is not null -- Example: only products with a color
