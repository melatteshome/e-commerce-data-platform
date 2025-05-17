{{config(materialized='table')}}

WITH "transaction" AS (
  SELECT
    transaction_id,
    payment_method,
    payment_status,
    product_id,
    quantity
  FROM {{ ref('int_transaction_exploded_products') }}
),

product AS (
  SELECT
    product_id,
    season,
    product_full_category,
    product_display_name,
    gender
  FROM {{ ref('mart_product') }}
),

joined AS (
  SELECT
    t.product_id,
    p.season,
    t.quantity,
    p.product_display_name,
    p.product_full_category
  FROM "transaction" t
  JOIN product p
    ON t.product_id = p.product_id
  WHERE t.payment_status = 'success'
),

seasonly_sales AS (
  SELECT
    season,
    product_id,
    product_display_name,
    product_full_category,
    SUM(quantity) AS total_units_sold

  FROM joined
  GROUP BY 1, 2 , 3 , 4
),

ranked_sales AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY season
      ORDER BY total_units_sold DESC
    ) AS row_num
  FROM seasonly_sales
)

SELECT
  season,
  product_id,
  product_full_category,
  product_display_name,
  total_units_sold
FROM ranked_sales
WHERE  row_num = 1 AND season IS NOT NULL
ORDER BY season

