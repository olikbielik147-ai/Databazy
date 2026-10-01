SELECT product_name, total_amount, total_amount / (SELECT SUM(total_amount) FROM flourmills_sales) amount_share
FROM flourmills_sales;
