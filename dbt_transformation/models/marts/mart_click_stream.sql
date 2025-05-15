-- models/marts/mart_click_stream.sql
{{ config(materialized='table') }}

with events as (

    select * from {{ ref('int_click_stream') }}

),

aggregated as (

    select
        session_id,
        min(event_timestamp) as session_start_time,ls
        max(event_timestamp) as session_end_time,
        count(*) as total_events,
        count(distinct event_name) as unique_event_types
    from events
    group by session_id

)

select * from aggregated
