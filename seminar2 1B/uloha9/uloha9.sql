SELECT o.product_name,
       o.region,
       o.total_amount,
       (
         SELECT MIN(i.total_amount)
         FROM flourmills_sales AS i
         WHERE i.region = o.region
       ) AS region_min_amount
FROM flourmills_sales AS o;
