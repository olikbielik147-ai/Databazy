WITH first_purchases AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS first_order_month
    FROM orders
    GROUP BY customer_id
),
returning_customers AS (
    SELECT DISTINCT f.customer_id
    FROM first_purchases f
    JOIN orders o ON f.customer_id = o.customer_id
    WHERE f.first_order_month = '2024-06-01'
      AND DATE_TRUNC('month', o.order_date) > f.first_order_month
)
SELECT COUNT(*) 
FROM returning_customers;