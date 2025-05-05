with promos as (
    select *
    from {{ source('sql_server_dbo', 'promos') }}
)

select *
from promos
