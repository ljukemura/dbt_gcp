SELECT
  customer_id,
  MIN(customer_name) OVER(PARTITION BY customer_id ORDER BY updated_at DESC) AS customer_name,
  MIN(updated_at) OVER(PARTITION BY customer_id) AS created_at,
  MAX(updated_at) OVER(PARTITION BY customer_id) AS last_updated_at,
  COUNT(*) OVER(PARTITION BY customer_id) AS total_changes
FROM
  `dbt-felix`.`sources`.`customers`
QUALIFY ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY updated_at DESC) = 1
