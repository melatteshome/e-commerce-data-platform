-- models/intermediate/int_products.sql

with products as (

    select * 
    from {{ ref('stg_products') }}

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
        year,
        usage_type,
        product_display_name,
        
        -- Derived fields
        case
            when year >= 2020 then 'new'
            else 'old'
        end as product_age_category,
        
        concat_ws(' - ', master_category, sub_category, article_type) as product_full_category

    from products

)

select * 
from enhanced
