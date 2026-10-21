with source as (

    select * from {{ source('snapchat', 'campaign_history') }}

),

renamed as (

    select
        campaign_id,
        account_id,
        campaign_name

    from source

)

select * from renamed
