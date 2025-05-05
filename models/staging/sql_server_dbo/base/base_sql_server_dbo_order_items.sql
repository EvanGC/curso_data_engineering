with order_items as (
    SELECT * FROM {{ source('sql_server_dbo', 'order_items') }}
) SELECT {{ dbt_utils.generate_surrogate_key(["product_id", "order_id"]) }} as order_product_id,
    * 
    FROM order_items