SELECT
  customer_id,
  customer_name,
  MIN(updated_at) AS created_at,
  MAX(updated_at) AS updated_at,
  COUNT(*) OVER(PARTITION BY customer_id) AS total_changes
FROM
  {{ source('sources', 'customers') }}
GROUP BY customer_id, customer_name
QUALIFY ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY updated_at DESC) = 1
