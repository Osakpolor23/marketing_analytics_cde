with source as (

    select * from {{ source('facebook', 'accounts') }}

),

renamed as (

    select
        account_id,
        account_name,
        upper(ad_currency_code) as ad_currency_code,
        cast(account_created_at as timestamp) as account_created_at,
        cast(account_updated_at as timestamp) as account_updated_at

    from source

)

select * from renamed
