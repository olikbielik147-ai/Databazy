SELECT o.product_name, o.sale_date, o.total_amount
FROM flourmills_sales AS o
WHERE EXISTS (
  SELECT 1
  FROM flourmills_sales AS i
  WHERE i.product_name = o.product_name
  GROUP BY i.product_name
  HAVING COUNT(DISTINCT DATE_TRUNC('month', i.sale_date)) > 1
);
