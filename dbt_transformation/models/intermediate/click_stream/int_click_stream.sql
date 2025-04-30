-- models/intermediate/int_click_stream.sql

with events as (

    select * from {{ ref('stg_click_stream') }}

),

parsed as (

    select
        session_id,
        event_name,
        event_timestamp,
        event_id,
        traffic_source,
        event_metadata
    from events

)

select * from parsed
