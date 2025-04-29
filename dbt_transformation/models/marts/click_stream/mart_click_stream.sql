-- models/marts/mart_click_stream.sql

with events as (

    select * from {{ ref('int_click_stream') }}

),

aggregated as (

    select
        session_id,
        min(event_timestamp) as session_start_time,
        max(event_timestamp) as session_end_time,
        count(*) as total_events,
        count(distinct event_name) as unique_event_types,
        any_value(device_type) as device_type,
        any_value(browser_type) as browser_type,
        any_value(traffic_source) as traffic_source
    from events
    group by session_id

)

select * from aggregated
