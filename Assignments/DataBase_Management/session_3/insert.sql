INSERT INTO students (roll_no, student_name, class, city, email)
VALUES
(1, 'Aarav Patel', '9A', 'Ahmedabad', 'aarav@gmail.com'),
(2, 'Riya Shah', '9A', 'Mumbai', 'riya@gmail.com'),
(3, 'Krish Mehta', '9A', 'Surat', 'krish@gmail.com'),
(4, 'Anaya Joshi', '9A', 'Jaipur', 'anaya@gmail.com'),
(5, 'Dev Sharma', '9B', 'Pune', 'dev@gmail.com'),
(6, 'Diya Verma', '9B', 'Delhi', 'diya@gmail.com'),
(7, 'Reyansh Desai', '9B', 'Vadodara', 'reyansh@gmail.com'),
(8, 'Myra Singh', '9B', 'Bengaluru', 'myra@gmail.com');


-- insert into subjects table

INSERT INTO subjects (subject_id, subject_name, max_marks)
VALUES
(1, 'Maths', 100),
(2, 'Science', 100),
(3, 'English', 100),
(4, 'Hindi', 100),
(5, 'Social Science', 100);


-- show queries
SELECT * FROM students;

SELECT * FROM subjects;