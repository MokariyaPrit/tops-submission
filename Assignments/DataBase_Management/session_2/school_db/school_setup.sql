 CREATE DATABASE IF NOT EXISTS school_db;

use school_db;

create TABLE  students (
    roll_no INT primary key, 
    name VARCHAR(50) not null, 
    class VARCHAR(10),
     city VARCHAR(30));

DESCRIBE students;