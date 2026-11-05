USE foodapp_db;
CREATE TABLE orders(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders
(restaurant_id, customer_name, total_amount, order_date)
VALUES
(1, 'Rahul', 1200, '2026-11-01'),
(1, 'Priya', 1500, '2026-11-02'),
(1, 'Amit', 1800, '2026-11-03'),

(2, 'Neha', 2000, '2026-11-01'),
(2, 'Karan', 1700, '2026-11-02'),
(2, 'Riya', 1600, '2026-11-04'),

(4, 'Mehul', 2500, '2026-11-01'),
(4, 'Anjali', 3000, '2026-11-03'),
(4, 'Jay', 1800, '2026-11-05'),

(5, 'Pooja', 900, '2026-11-02'),
(5, 'Krish', 1100, '2026-11-04'),
(5, 'Sahil', 1300, '2026-11-05');



SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY restaurant_id;


SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY restaurant_id
HAVING SUM(total_amount) > 5000;


SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;