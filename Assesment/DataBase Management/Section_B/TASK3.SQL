USE foodapp_db;

CREATE TABLE restaurant(
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50),

    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id)
);

INSERT INTO restaurants (name, city)
VALUES
('Pizza Palace', 'Ahmedabad'),
('Food Corner', 'Surat'),
('Burger Hub', 'Mumbai'),
('Spice Garden', 'Vadodara'),
('South Treat', 'Ahmedabad');


INSERT INTO menu_items
(restaurant_id, item_name, price, category)
VALUES
(1, 'Margherita Pizza', 250, 'Pizza'),
(1, 'Cheese Pizza', 350, 'Pizza'),
(1, 'Garlic Bread', 150, 'Starter'),

(2, 'Paneer Tikka', 220, 'Starter'),
(2, 'Veg Thali', 180, 'Main Course'),
(2, 'Dal Rice', 120, 'Main Course'),

(3, 'Veg Burger', 100, 'Burger'),
(3, 'Cheese Burger', 150, 'Burger'),
(3, 'French Fries', 90, 'Starter'),

(4, 'Paneer Masala', 250, 'Main Course'),
(4, 'Butter Naan', 40, 'Bread'),
(4, 'Veg Biryani', 200, 'Rice');


SELECT
    restaurants.name,
    menu_items.item_name,
    menu_items.price
FROM restaurants
INNER JOIN menu_items
ON restaurants.restaurant_id = menu_items.restaurant_id;

SELECT
    restaurants.name,
    menu_items.item_name,
    menu_items.price
FROM restaurants
LEFT JOIN menu_items
ON restaurants.restaurant_id = menu_items.restaurant_id;


CREATE VIEW restaurant_menu_summary AS
SELECT
    r.name AS restaurant_name,
    COUNT(m.item_id) AS total_menu_items,
    AVG(m.price) AS average_item_price
FROM restaurants r
LEFT JOIN menu_items m
ON r.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_id, r.name;


SELECT * FROM restaurant_menu_summary;