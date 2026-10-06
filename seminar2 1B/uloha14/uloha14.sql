SELECT DISTINCT o.product_category
FROM flourmills_sales AS o
WHERE NOT EXISTS (
  SELECT 1
  FROM flourmills_sales AS i
  WHERE i.product_category = o.product_category
    AND i.total_amount > 500000
);
