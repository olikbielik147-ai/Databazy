SELECT c.region AS region,
       SUM(CASE WHEN o.sales > 1000 THEN 1 ELSE 0 END) AS high_value_count,
       SUM(CASE WHEN o.sales <= 1000 THEN 1 ELSE 0 END) AS low_value_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY c.region;
