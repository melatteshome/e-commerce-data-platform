{{config(materialized='table')}}

with tr as (
    select
        customer_id,
        booking_id as transaction_id,
        shipment_date_limit:: date as order_date,
        total_amount as revenue
    from {{ ref('stg_transaction')}}
),

customer as (
    select 
        customer_id,
        home_location
    from {{ ref('int_customer')}}
),

params as(
    select current_date as snapshot_date
),

rfm_base as  (
  select 
    tr.customer_id,
    date_part(
      'day', 
      p.snapshot_date::timestamp
        - MAX(tr.order_date)::timestamp
    ) as recency,
    COUNT(distinct tr.transaction_id) as frequency,
    SUM(tr.revenue) as monetary,
    
  from tr
  cross join params p
  group by
    tr.customer_id,
    p.snapshot_date    
),


rfm_score as(
    select 
        customer_id,
        recency,
        frequency,
        monetary,
        ntile(5) over (order by recency asc) as recency_score,
        ntile(5) over (order by frequency desc) as frequency_score,
        ntile(5) over (order by monetary desc) as monetary_score
    from rfm_base
),

rfm_code as (
  select
    customer_id,
    recency, frequency, monetary,
    recency_score,
    frequency_score,
    monetary_score,
    concat(
      recency_score::text,'-',
      frequency_score::text,'-',
      monetary_score::text
    ) as rfm_score
  from rfm_score
),

rfm_segments as (
  select
    *,
    case
      when recency_score >= 4
       and frequency_score >= 4
       and monetary_score >= 4 then 'Champions'
      when recency_score >= 3
       and frequency_score >= 3
       and monetary_score >= 3 then 'Loyal Customers'
      when recency_score <= 2
       and frequency_score >= 4 then 'At Risk'
      when recency_score = 5
       and frequency_score <= 2 then 'New Customers'
      else 'Others'
    end as segment
  from rfm_code
)

select * from rfm_segments