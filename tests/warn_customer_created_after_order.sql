WITH mismatches AS (
  SELECT
    c.customer_id,
    c.created_at AS customer_created_at,
    o.created_at AS order_created_at
  FROM {{ ref('b_customer') }} AS c
  JOIN {{ ref('s_orders') }}   AS o ON c.customer_id = o.customer_id
  WHERE c.created_at > o.created_at
)

SELECT * FROM mismatches