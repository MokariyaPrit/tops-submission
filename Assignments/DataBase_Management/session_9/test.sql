USE canteen_db;

-- =====================================
-- TEST 1: Check stock reduction
-- ChatGPT expected: Stock decreases by exactly 3.
-- MySQL actual: Write your actual result here.

START TRANSACTION;

INSERT INTO orders (item_id, quantity)
VALUES (1, 3);

COMMIT;

SELECT * FROM menu_items WHERE item_id = 1;


-- =====================================
-- TEST 2: Check SAVEPOINT and ROLLBACK
-- ChatGPT expected: Only 2 plates are deducted.
-- MySQL actual: Write your actual result here.

START TRANSACTION;

INSERT INTO orders (item_id, quantity)
VALUES (1, 2);

SAVEPOINT test_savepoint;

INSERT INTO orders (item_id, quantity)
VALUES (1, 500);

ROLLBACK TO test_savepoint;

COMMIT;

SELECT * FROM menu_items WHERE item_id = 1;


-- =====================================
-- TEST 3: Check invalid item rollback
-- ChatGPT expected: Order failed; no order for item 99.
-- MySQL actual: Write your actual result here.

CALL place_order(99, 2);

SELECT * FROM orders
WHERE item_id = 99;

SELECT * FROM menu_items
WHERE item_id = 99;