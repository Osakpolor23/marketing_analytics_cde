with source as (

    select * from {{ source('snapchat', 'adgroup_history') }}

),

renamed as (

    select
        ad_group_id,
        campaign_id,
        ad_group_name,
        cast(ad_group_updated_at as timestamp) as ad_group_updated_at,
        _surrogate_key

    from source

),

-- Keep only the latest version of each ad group by deduplicating
latest as (

    select
        ad_group_id,
        campaign_id,
        ad_group_name,
        ad_group_updated_at,
        _surrogate_key,
        row_number() over (
            partition by ad_group_id
            order by ad_group_updated_at desc, _surrogate_key desc
        ) as rn
    from renamed
)

select
    ad_group_id,
    campaign_id,
    ad_group_name,
    ad_group_updated_at
from latest
where rn = 1
