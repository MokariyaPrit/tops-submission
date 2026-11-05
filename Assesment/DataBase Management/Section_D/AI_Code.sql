
USE food_delivery_db;

DELIMITER //

CREATE PROCEDURE restaurant_monthly_summary(
    IN p_restaurant_id INT,
    IN p_month INT
)
BEGIN

    IF EXISTS (
        SELECT 1
        FROM orders
        WHERE restaurant_id = p_restaurant_id
        AND MONTH(order_date) = p_month
    ) THEN

        SELECT
            restaurant_id,
            COUNT(order_id) AS total_orders,
            SUM(total_amount) AS total_revenue,
            AVG(total_amount) AS average_order_value
        FROM orders
        WHERE restaurant_id = p_restaurant_id
        AND MONTH(order_date) = p_month
        GROUP BY restaurant_id;

    ELSE
        SELECT 'No orders found for this restaurant in the selected month'
        AS message;

    END IF;

END //

DELIMITER ;

CALL restaurant_monthly_summary(1, 11);

CALL restaurant_monthly_summary(2, 10);