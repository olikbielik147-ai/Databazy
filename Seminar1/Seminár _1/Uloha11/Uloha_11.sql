SELECT c.region AS region,
       SUM(o.sales) AS total_sales,
       AVG(o.discount) AS avg_discount,
       COUNT(o.order_id) AS orders_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY region;
