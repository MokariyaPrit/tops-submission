USE foodapp_db;

DROP PROCEDURE IF EXISTS place_order;
DELIMITER //

CREATE PROCEDURE place_order(
    IN p_customer_id INT,
    IN p_restaurant_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_balance DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT wallet_balance
    INTO v_balance
    FROM customers
    WHERE customer_id = p_customer_id
    FOR UPDATE;

    IF v_balance IS NULL OR p_amount <= 0 THEN

        ROLLBACK;
        SELECT 'Invalid customer or amount' AS message;

    ELSEIF v_balance < p_amount THEN

        ROLLBACK;
        SELECT 'Insufficient wallet balance' AS message;

    ELSE

        UPDATE customers
        SET wallet_balance = wallet_balance - p_amount
        WHERE customer_id = p_customer_id;

        INSERT INTO orders
        (customer_id, restaurant_id, total_amount, order_date)
        VALUES
        (p_customer_id, p_restaurant_id, p_amount, CURDATE());

        COMMIT;

        SELECT 'Order placed successfully' AS message;

    END IF;

END 

DELIMITER ;

CALL place_order(1, 1, 500);

CALL place_order(1, 1, 6000);