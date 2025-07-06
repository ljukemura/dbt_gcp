SELECT
  CONCAT(d.order_id, d.product_id) as detail_order_id,
  d.order_id,
  d.updated_at,
  d.product_id,
  p.product_name,
  d.quantity,
  p.price AS unit_price,
  d.quantity * p.price AS total_price
FROM `dbt-felix.sources.order_details` AS d   
  LEFT JOIN `dbt-felix.sources.products` AS p ON d.product_id = p.product_id