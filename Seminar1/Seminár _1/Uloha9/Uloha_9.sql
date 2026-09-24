SELECT p.category AS category,
       AVG(o.discount) AS avg_discount
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY p.category;