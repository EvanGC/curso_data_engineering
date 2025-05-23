with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        IFF(promo_id IS NULL OR promo_id = '', 'sin promo', promo_id) AS promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

), final as(

    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from renamed
)

select * from final