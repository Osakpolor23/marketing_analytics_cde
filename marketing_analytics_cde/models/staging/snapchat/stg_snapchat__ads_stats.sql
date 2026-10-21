with source as (

    select * from {{ source('snapchat', 'ads_stats') }}

),

renamed as (

    select
        -- surrogate key for the ad stats table
        {{ dbt_utils.generate_surrogate_key(['ad_detail_id', 'ad_country', 'ad_date']) }} as ad_stat_id,
        ad_detail_id as ad_id,
        upper(ad_country) as ad_country,
        upper(ad_currency_code) as ad_currency_code,
        cast(ad_date as date) as ad_date,
        cast(ad_spend as decimal(18, 6)) as ad_spend,
        cast(ad_impressions as bigint) as ad_impressions,
        try_cast(nullif(ad_clicks, 'null') as bigint) as ad_clicks,
        data_src as data_source

    from source

)

select * from renamed
