SELECT region, total_sales
FROM (
  SELECT c.region AS region, SUM(o.sales) AS total_sales
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  GROUP BY c.region

  UNION 

  SELECT region, 0 AS total_sales
  FROM customers
  WHERE region NOT IN (
    SELECT c.region
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
  )
  GROUP BY region
) t
ORDER BY total_sales DESC;