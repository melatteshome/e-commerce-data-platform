with source as (
    SELECT 
        id,
        gender,
        masterCategory,
        subCategory,
        articleType,
        baseColour,
        season,
        year,
        usage,
        productDisplayName
    from {{source('e-commerce', 'product')}}
),

renamed as (
    SELECT
        id as product_id,
        lower(trim(gender)) as gender,
        lower(trim(masterCategory)) as master_category,
        lower(trim(subCategory)) as sub_category,
        lower(trim(articleType)) as article_type,
        lower(trim(baseColour)) as base_colour,
        lower(trim(season)) as season,
        SPLIT_PART(year, '.', 1) AS year_time,
        lower(trim(usage)) as usage_type,
        productDisplayName as product_display_name
    from source
)

SELECT * from renamed