SELECT
  o.order_id,
  o.customer_id,
  o.order_date,
  o.updated_at AS created_at,
  FORMAT_DATE('%A', DATE(o.updated_at)) AS weekday_name,
  COUNT(DISTINCT d.product_id) AS num_products,
  COALESCE(SUM(d.quantity), 0) AS num_items,
  COALESCE(SUM(d.total_price), 0) AS total_spent,
  SUM(d.quantity) IS NULL AS flag_order_empyt
FROM {{ source("sources", "orders") }} o
  LEFT JOIN {{ ref("s_order_details") }} d ON d.order_id = o.order_id
GROUP BY o.order_id, o.customer_id, o.order_date, o.updated_at