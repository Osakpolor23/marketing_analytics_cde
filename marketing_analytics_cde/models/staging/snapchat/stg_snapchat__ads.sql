with source as (

    select * from {{ source('snapchat', 'ad_history') }}

),

renamed as (

    select
        ad_id,
        ad_group_id,
        ad_name,
        cast(ad_detail_updated_at as timestamp) as ad_updated_at

    from source

),

-- Keep only the latest version of each ad
latest as (

    select
        ad_id,
        ad_group_id,
        ad_name,
        ad_updated_at,
        row_number() over (
            partition by ad_id
            order by ad_updated_at desc
        ) as rn
    from renamed
)

select * except (rn)
from latest
where rn = 1
