-- models/staging/stg_click_stream.sql

with source as (

    select
        session_id,
        event_name,
        event_time,
        event_id,
        traffic_source,
        event_metadata
    from {{ source('e-commerce', 'click_stream') }}

),

renamed as (

    select
        trim(session_id) as session_id,
        lower(trim(event_name)) as event_name,
        cast(event_time as timestamp) as event_timestamp,
        trim(event_id) as event_id,
        lower(trim(traffic_source)) as traffic_source,
        cast(event_metadata as json) as event_metadata
    from source

)

select * from renamed
