with products as (

    select * 
    from {{ ref('stg_product') }}

),

enhanced as (

    select
        product_id,
        gender,
        master_category,
        sub_category,
        article_type,
        base_colour,
        season,
        year_time,
        usage_type,
        product_display_name,        
        concat_ws(' - ', master_category, sub_category, article_type) as product_full_category

    from products

)

select * 
from enhanced
