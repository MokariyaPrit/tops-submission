
DROP DATABASE IF EXISTS canteen_db;

CREATE DATABASE canteen_db;

USE canteen_db;

-- Create menu_items table
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50),
    price DECIMAL(6,2),
    stock INT
);

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- Insert 6 canteen items
INSERT INTO menu_items (item_id, item_name, price, stock)
VALUES
(1, 'Samosa', 15, 50),
(2, 'Sandwich', 40, 30),
(3, 'Vadapav', 20, 60),
(4, 'Dosa', 60, 25),
(5, 'Tea', 10, 100),
(6, 'Pizza', 80, 20);

-- Display menu items
SELECT * FROM menu_items;

-- Display orders
SELECT * FROM orders;
