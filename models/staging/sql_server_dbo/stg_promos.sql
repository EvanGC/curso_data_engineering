with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

), sin_promo as(
    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

    UNION ALL

    SELECT 'sin promo', 0, 'active', null, GETDATE()

), renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
        promo_id as promo_name,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from sin_promo

)

select * from renamed
