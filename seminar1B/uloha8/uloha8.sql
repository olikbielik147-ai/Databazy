SELECT o.product_name, o.product_category, o.total_amount
FROM flourmills_sales AS o
WHERE o.total_amount > (
  SELECT AVG(i.total_amount)
  FROM flourmills_sales AS i
  WHERE i.product_category = o.product_category
);
