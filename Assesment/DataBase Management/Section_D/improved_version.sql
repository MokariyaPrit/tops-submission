
USE food_delivery_db;


DROP PROCEDURE IF EXISTS restaurant_monthly_summary;
DROP PROCEDURE IF EXISTS restaurant_monthly_summary_fixed;
DELIMITER //
CREATE PROCEDURE restaurant_monthly_summary_fixed(
    IN p_restaurant_id INT,
    IN p_month INT
) 
BEGIN

    -- Validate month
    IF p_month < 1 OR p_month > 12 THEN

        SELECT 'Invalid month! Enter a month between 1 and 12.'
        AS message; 

    ELSEIF EXISTS (
        SELECT 1
        FROM orders
        WHERE restaurant_id = p_restaurant_id
        AND MONTH(order_date) = p_month
        AND YEAR(order_date) = YEAR(CURDATE())
    ) THEN

        SELECT
            restaurant_id,
            COUNT(order_id) AS total_orders,
            SUM(total_amount) AS total_revenue,
            AVG(total_amount) AS average_order_value

        FROM orders

        WHERE restaurant_id = p_restaurant_id
        AND MONTH(order_date) = p_month
        AND YEAR(order_date) = YEAR(CURDATE())

        GROUP BY restaurant_id;

    ELSE

        SELECT 'No orders found for this restaurant in the selected month and year.'
        AS message;

    END IF;

END 

DELIMITER ;

CALL restaurant_monthly_summary_fixed(1, 11);

CALL restaurant_monthly_summary_fixed(2, 10);

CALL restaurant_monthly_summary_fixed(999, 11);