SELECT o.product_category, o.product_name, o.total_amount
FROM flourmills_sales AS o
WHERE EXISTS (
  SELECT 1
  FROM flourmills_sales AS i
  WHERE i.product_category = o.product_category
    AND i.total_amount > 200000
);