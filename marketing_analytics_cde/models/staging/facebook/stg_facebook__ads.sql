with source as (

    select * from {{ source('facebook', 'ads') }}

),

renamed as (

    select
        ad_id,
        ad_group_id,
        campaign_id,
        account_id,
        ad_name,
        upper(ad_status) as ad_status,
        cast(ad_updated_at as timestamp) as ad_updated_at

    from source

)

select * from renamed
