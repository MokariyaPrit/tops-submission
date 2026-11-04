
USE canteen_db;

DELIMITER $$

CREATE PROCEDURE restock_all(IN p_amount INT)
BEGIN
    DECLARE counter INT DEFAULT 1;

    my_loop: LOOP

        UPDATE menu_items
        SET stock = stock + p_amount
        WHERE item_id = counter;

        SET counter = counter + 1;

        IF counter > 6 THEN
            LEAVE my_loop;
        END IF;

    END LOOP my_loop;

END $$

DELIMITER ;

-- Call the procedure
CALL restock_all(25);

-- Display updated stock
SELECT * FROM menu_items;
