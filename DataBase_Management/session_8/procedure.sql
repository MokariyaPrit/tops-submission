
USE canteen_db;

-- Set stock for three items
UPDATE menu_items SET stock = 0 WHERE item_id = 1;
UPDATE menu_items SET stock = 10 WHERE item_id = 2;
UPDATE menu_items SET stock = 50 WHERE item_id = 3;

-- Create stored procedure
DELIMITER $$

CREATE PROCEDURE show_item_status(IN p_item_id INT)
BEGIN
    DECLARE v_stock INT;

    SELECT stock INTO v_stock
    FROM menu_items
    WHERE item_id = p_item_id;

    IF v_stock = 0 THEN
        SELECT 'Out of stock' AS item_status;

    ELSEIF v_stock < 20 THEN
        SELECT 'Low stock' AS item_status;

    ELSE
        SELECT 'In stock' AS item_status;

    END IF;

END $$

DELIMITER ;

-- Call procedure for three items
CALL show_item_status(1);
CALL show_item_status(2);
CALL show_item_status(3);
