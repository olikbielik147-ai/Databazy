SELECT DISTINCT r.region
FROM flourmills_sales AS r
WHERE NOT EXISTS (
  SELECT 1
  FROM flourmills_sales AS s
  WHERE s.region = r.region
    AND s.product_category = 'Flour'
);
