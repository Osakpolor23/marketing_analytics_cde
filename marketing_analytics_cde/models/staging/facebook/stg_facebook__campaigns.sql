with source as (

    select * from {{ source('facebook', 'campaigns') }}

),

renamed as (

    select
        campaign_id,
        campaign_name,
        cast(campaign_updated_at as timestamp) as campaign_updated_at

    from source

)

select * from renamed
