SELECT
  o.order_id,
  o.customer_id,
  o.order_date,
  o.updated_at AS created_at,
  COUNT(DISTINCT d.product_id) AS qtd_produtos,
  COALESCE(SUM(d.quantity), 0) AS qtd_itens,
  COALESCE(SUM(d.total_price), 0) AS total_gasto,
  SUM(d.quantity) IS NULL AS flag_order_empyt
FROM `dbt-felix.sources.orders` o
  LEFT JOIN `dbt-felix.dbt_lj_sandbox.s_order_details` d ON d.order_id = o.order_id
GROUP BY o.order_id, o.customer_id, o.order_date, o.updated_at