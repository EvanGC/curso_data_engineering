SELECT *
FROM {{ ref('test') }}
WHERE delivered_at < created_at