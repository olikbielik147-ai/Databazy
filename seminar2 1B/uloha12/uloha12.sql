SELECT DISTINCT o.product_category
FROM flourmills_sales AS o
WHERE EXISTS (
  SELECT 1
  FROM flourmills_sales AS i
  WHERE i.product_category = o.product_category
  GROUP BY i.product_category
  HAVING COUNT(DISTINCT i.region) > 3
);
