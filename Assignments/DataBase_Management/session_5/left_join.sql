INSERT INTO students (roll_no, student_name, class, city, email)
VALUES (9, 'Ishita Patel', '10A', 'Ahmedabad', 'ishita@gmail.com');


SELECT
    s.roll_no,
    s.student_name,
    s.class
FROM students AS s
LEFT JOIN marks AS m
    ON s.roll_no = m.roll_no
WHERE m.roll_no IS NULL;


