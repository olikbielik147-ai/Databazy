SELECT product_name, total_amount, (SELECT AVG(total_amount) FROM flourmills_sales) avg_amount
FROM flourmills_sales;