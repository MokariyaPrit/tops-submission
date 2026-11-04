USE canteen_db;

USE canteen_db;

DELIMITER //

CREATE PROCEDURE place_order(
    IN p_item_id INT,
    IN p_qty INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Order failed' AS Message;
    END;

    START TRANSACTION;

    INSERT INTO orders (item_id, quantity)
    VALUES (p_item_id, p_qty);

    UPDATE menu_items
    SET stock = stock - p_qty
    WHERE item_id = p_item_id;

    COMMIT;

END //

DELIMITER ;

CALL place_order(1, 2);



CALL place_order(99, 2);

SELECT * FROM orders;

SELECT * FROM menu_items;