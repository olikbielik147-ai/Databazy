SELECT o.product_name, o.region, o.total_amount
FROM flourmills_sales AS o
WHERE EXISTS (
  SELECT 1
  FROM flourmills_sales AS i
  WHERE i.region = o.region
    AND EXTRACT(YEAR FROM i.sale_date) = 2024
);
