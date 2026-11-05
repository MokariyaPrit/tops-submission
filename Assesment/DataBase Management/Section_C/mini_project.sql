
-- ==========================================
-- FOOD DELIVERY APPLICATION DATABASE
-- ==========================================

CREATE DATABASE IF NOT EXISTS food_delivery_db;
USE food_delivery_db;

-- ==========================================
-- 1. DROP OLD OBJECTS (FOR RERUNNING)
-- ==========================================

DROP VIEW IF EXISTS restaurant_sales_summary;
DROP PROCEDURE IF EXISTS add_order;
DROP TRIGGER IF EXISTS after_order_insert;

DROP TABLE IF EXISTS order_audit;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

-- ==========================================
-- 2. CREATE RESTAURANTS TABLE
-- ==========================================

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. CREATE MENU_ITEMS TABLE
-- ==========================================

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,

    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id),

    CHECK (price > 0)
);

-- ==========================================
-- 4. CREATE ORDERS TABLE
-- ==========================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    restaurant_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (item_id)
    REFERENCES menu_items(item_id),

    CHECK (quantity > 0),
    CHECK (total_amount > 0)
);

-- ==========================================
-- 5. CREATE ORDER AUDIT TABLE
-- ==========================================

CREATE TABLE order_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    `action` VARCHAR(20) NOT NULL,
    log_time DATETIME NOT NULL
);

-- ==========================================
-- 6. INSERT RESTAURANTS
-- ==========================================

INSERT INTO restaurants
(restaurant_id, name, city, cuisine_type)
VALUES
(1, 'Spice Garden', 'Ahmedabad', 'Indian'),
(2, 'Pizza Palace', 'Ahmedabad', 'Italian'),
(3, 'Burger Hub', 'Surat', 'Fast Food');

-- ==========================================
-- 7. INSERT MENU ITEMS
-- ==========================================

INSERT INTO menu_items
(item_id, restaurant_id, item_name, price, category)
VALUES
(101, 1, 'Paneer Tikka', 180, 'Starter'),
(102, 1, 'Gujarati Thali', 250, 'Main Course'),
(103, 1, 'Masala Dosa', 120, 'Main Course'),
(104, 1, 'Gulab Jamun', 80, 'Dessert'),
(105, 1, 'Mango Lassi', 60, 'Beverage'),

(201, 2, 'Margherita Pizza', 220, 'Main Course'),
(202, 2, 'Farmhouse Pizza', 300, 'Main Course'),
(203, 2, 'Garlic Bread', 100, 'Starter'),
(204, 2, 'Chocolate Brownie', 120, 'Dessert'),
(205, 2, 'Cold Coffee', 90, 'Beverage'),

(301, 3, 'Veg Burger', 100, 'Main Course'),
(302, 3, 'Cheese Burger', 150, 'Main Course'),
(303, 3, 'French Fries', 80, 'Starter'),
(304, 3, 'Chocolate Shake', 110, 'Beverage'),
(305, 3, 'Ice Cream', 70, 'Dessert');

-- ==========================================
-- 8. CREATE TRIGGER
-- ==========================================

DELIMITER //

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit
    (order_id, restaurant_id, `action`, log_time)
    VALUES
    (NEW.order_id, NEW.restaurant_id, 'INSERT', NOW());
END 

DELIMITER ;

-- ==========================================
-- 9. INSERT 15 SAMPLE ORDERS
-- ==========================================

INSERT INTO orders
(customer_name, restaurant_id, item_id, quantity, total_amount)
VALUES
('Amit', 1, 101, 2, 360),
('Priya', 1, 102, 1, 250),
('Rahul', 1, 103, 2, 240),
('Neha', 1, 104, 3, 240),
('Karan', 1, 105, 2, 120),

('Riya', 2, 201, 2, 440),
('Jay', 2, 202, 1, 300),
('Meera', 2, 203, 2, 200),
('Dev', 2, 204, 1, 120),
('Pooja', 2, 205, 2, 180),

('Raj', 3, 301, 2, 200),
('Simran', 3, 302, 1, 150),
('Ankit', 3, 303, 3, 240),
('Diya', 3, 304, 2, 220),
('Krish', 3, 305, 2, 140);

-- ==========================================
-- 10. CREATE SALES SUMMARY VIEW
-- ==========================================

CREATE VIEW restaurant_sales_summary AS
SELECT
    r.restaurant_id,
    r.name AS restaurant_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue

FROM restaurants r

LEFT JOIN orders o
ON r.restaurant_id = o.restaurant_id

GROUP BY r.restaurant_id, r.name;

-- ==========================================
-- 11. CREATE STORED PROCEDURE
-- ==========================================

DELIMITER //

CREATE PROCEDURE add_order(
    IN p_customer_name VARCHAR(100),
    IN p_restaurant_id INT,
    IN p_item_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_restaurant_count INT DEFAULT 0;
    DECLARE v_item_count INT DEFAULT 0;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);

    -- Rollback if any SQL error occurs
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Check restaurant exists
    SELECT COUNT(*)
    INTO v_restaurant_count
    FROM restaurants
    WHERE restaurant_id = p_restaurant_id;

    IF v_restaurant_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Restaurant does not exist';
    END IF;

    -- Check item belongs to selected restaurant
    SELECT COUNT(*)
    INTO v_item_count
    FROM menu_items
    WHERE item_id = p_item_id
    AND restaurant_id = p_restaurant_id;

    IF v_item_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid menu item or restaurant';
    END IF;

    -- Validate quantity
    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    -- Get item price
    SELECT price
    INTO v_price
    FROM menu_items
    WHERE item_id = p_item_id;

    -- Calculate total amount
    SET v_total = v_price * p_quantity;

    -- Insert new order
    INSERT INTO orders
    (customer_name, restaurant_id, item_id,
     quantity, total_amount, order_date)

    VALUES
    (p_customer_name, p_restaurant_id, p_item_id,
     p_quantity, v_total, NOW());

    COMMIT;

    SELECT 'Order added successfully' AS message,
           LAST_INSERT_ID() AS order_id,
           v_total AS total_amount;

END 

DELIMITER ;

-- ==========================================
-- 12. TEST STORED PROCEDURE
-- ==========================================

CALL add_order('Darshana', 1, 101, 2);

-- ==========================================
-- 13. TEST INVALID RESTAURANT
-- ==========================================

-- Expected: Restaurant does not exist
-- No order should be inserted.

-- CALL add_order('Test Customer', 99, 101, 2);

-- ==========================================
-- 14. DISPLAY TABLES
-- ==========================================

SELECT * FROM restaurants;

SELECT * FROM menu_items;

SELECT * FROM orders;

-- ==========================================
-- 15. DISPLAY SALES SUMMARY VIEW
-- ==========================================

SELECT * FROM restaurant_sales_summary;

-- ==========================================
-- 16. DISPLAY ORDER AUDIT LOG
-- ==========================================

SELECT * FROM order_audit;

-- ==========================================
-- 17. JOIN QUERY
-- ==========================================

SELECT
    o.order_id,
    o.customer_name,
    r.name AS restaurant_name,
    m.item_name,
    m.category,
    o.quantity,
    o.total_amount,
    o.order_date

FROM orders o

INNER JOIN restaurants r
ON o.restaurant_id = r.restaurant_id

INNER JOIN menu_items m
ON o.item_id = m.item_id;



-- Check restaurant sales
SELECT * FROM restaurant_sales_summary;

--. Check JOIN
SELECT *
FROM orders o
INNER JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
INNER JOIN menu_items m
ON o.item_id = m.item_id;


-- Check trigger
SELECT * FROM order_audit;


-- Test valid stored procedure
CALL add_order('Amit', 2, 201, 3);


-- Expected total: 660.

-- Test invalid restaurant
CALL add_order('Rahul', 99, 101, 2);

--Check final orders
SELECT * FROM orders;
