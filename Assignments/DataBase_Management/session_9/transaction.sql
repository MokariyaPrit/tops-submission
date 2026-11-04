USE canteen_db;

START TRANSACTION;

-- Insert first order line
INSERT INTO orders (item_id, quantity)
VALUES (1, 2);

-- Insert second order line
INSERT INTO orders (item_id, quantity)
VALUES (2, 3);

-- Create savepoint
SAVEPOINT order_savepoint;

-- Mistaken third order line
INSERT INTO orders (item_id, quantity)
VALUES (1, 500);

-- Undo mistaken third order line
ROLLBACK TO order_savepoint;

-- Save final two orders
COMMIT;

-- Display orders table
SELECT * FROM orders;