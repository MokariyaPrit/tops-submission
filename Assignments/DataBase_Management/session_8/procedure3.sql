DROP PROCEDURE IF EXISTS inventory_value;
USE canteen_db;

DELIMITER $$

CREATE PROCEDURE inventory_value(OUT p_total DECIMAL(10,2))
BEGIN
    -- 1. Declare variables first
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_stock INT;
    DECLARE v_done INT DEFAULT 0;

    -- 2. Declare cursor
    DECLARE item_cursor CURSOR FOR
        SELECT price, stock FROM menu_items;

    -- 3. Declare NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = 1;

    SET p_total = 0;

    OPEN item_cursor;

    read_loop: LOOP

        FETCH item_cursor INTO v_price, v_stock;

        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET p_total = p_total + (v_price * v_stock);

    END LOOP read_loop;

    CLOSE item_cursor;

END $$

DELIMITER ;


CALL inventory_value(@total);

SELECT @total AS cursor_inventory_value;

SELECT SUM(price * stock) AS calculated_inventory_value
FROM menu_items;


