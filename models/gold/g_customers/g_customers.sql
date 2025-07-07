SELECT 
    o.customer_id,
    c.customer_name,
    SUM(o.total_spent) AS total_amount_spent,
    COUNT(o.order_id) AS num_orders,
    COUNTIF(o.is_order_empty) AS num_empty_orders,
    MIN(o.created_at) AS first_order_datetime,
    MAX(o.created_at) AS last_order_datetime
FROM {{ ref("s_orders") }} AS o
    LEFT JOIN {{ ref("b_customers") }} AS c ON c.customer_id = o.customer_id
GROUP BY o.customer_id , c.customer_name
ORDER BY total_spent DESC