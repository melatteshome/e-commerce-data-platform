-- models/marts/mart_products.sql

with final as (

    select * 
    from {{ ref('int_products') }}

)

select
    product_id,
    product_display_name,
    gender,
    base_colour,
    season,
    product_age_category,
    product_full_category
from final
where base_colour ,product_id , gender is not NULL
