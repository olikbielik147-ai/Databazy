CREATE OR REPLACE PROCEDURE get_sales_between(
    IN start_date DATE,
    IN end_date DATE
)
LANGUAGE plpgsql
AS $procedure$
DECLARE
    total_sales DECIMAL(10,2);
BEGIN
    SELECT SUM(sales)
    INTO total_sales
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date;

    RAISE NOTICE 'Sales from % to % = %', start_date, end_date, total_sales;
END;
$procedure$;

CALL get_sales_between('2024-01-01', '2024-03-31');