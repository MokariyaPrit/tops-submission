DROP DATABASE IF EXISTS school_db;

CREATE DATABASE school_db;
USE school_db;

-- Create scratch table
CREATE TABLE temp_notes (
    note_id INT PRIMARY KEY,
    note VARCHAR(100)
);

-- Remove scratch table
DROP TABLE temp_notes;

-- Display all tables
SHOW TABLES;

