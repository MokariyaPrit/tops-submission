CREATE DATABASE foodapp_db;

use foodapp_db;
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine_type VARCHAR(50),
    rating DECIMAL(3,1)
);
INSERT INTO restaurants (name, city, cuisine_type, rating)
VALUES
('Pizza Palace', 'Ahmedabad', 'Italian', 4.5),
('Food Corner', 'Surat', 'Indian', 4.2),
('Burger Hub', 'Mumbai', 'Fast Food', 3.9),
('Spice Garden', 'Ahmedabad', 'Punjabi', 4.7),
('South Treat', 'Vadodara', 'South Indian', 4.3),
('Chinese Wok', 'Surat', 'Chinese', 4.0);

UPDATE restaurants
SET rating = 4.8
WHERE restaurant_id = 1;

DELETE FROM restaurants
WHERE restaurant_id = 3;

SELECT *
FROM restaurants
ORDER BY rating DESC;

SELECT * FROM restaurants;