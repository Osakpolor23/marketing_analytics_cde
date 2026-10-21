with source as (

    select * from {{ source('facebook', 'ads_stats') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['ad_id', 'ad_date']) }} as ad_stat_id,
        ad_id,
        account_id,
        cast(ad_date as date) as ad_date,
        cast(ad_spend as decimal(18, 6)) as ad_spend,
        try_cast(nullif(ad_impressions, 'null') as bigint) as ad_impressions,
        try_cast(nullif(ad_clicks, 'null') as bigint) as ad_clicks

    from source

)

select * from renamed
