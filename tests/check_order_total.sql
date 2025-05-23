with orders as (
    select
        promo_id,
        order_cost,
        order_total,
        shipping_cost
    from {{ ref('stg_orders') }}
),

products as (
    select *
    from {{ ref('stg_promos') }}
),

order_total (
    select *
    from orders as o
    inner join products as p
        on o.promo_id = p.promo_id
    where order_total <> (order_cost + shipping_cost) - discount
)

select *
from order_total
