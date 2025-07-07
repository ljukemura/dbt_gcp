{{ 
  config(
    materialized='incremental',
    unique_key='detail_order_id',
    incremental_strategy='merge' 
  )
}}

WITH data AS (
  SELECT
    CONCAT(d.order_id, d.product_id) AS detail_order_id,
    d.order_id,
    d.updated_at,
    d.product_id,
    p.product_name,
    d.quantity,
    p.price    AS unit_price,
    d.quantity * p.price AS total_price
  FROM {{ source("sources", "order_details") }} AS d
  LEFT JOIN {{ source("sources", "products") }} AS p ON d.product_id = p.product_id
  WHERE 1=1
  {% if is_incremental() %}
    AND d.updated_at > (SELECT MAX(updated_at) FROM {{ this }})
  {% endif %}
)

SELECT * FROM data