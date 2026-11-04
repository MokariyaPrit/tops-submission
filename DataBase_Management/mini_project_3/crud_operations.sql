-- Insert 5 Students
INSERT INTO students (student_id, name, class, city)
VALUES
(1, 'Rahul', '10A', 'Ahmedabad'),
(2, 'Priya', '10B', 'Surat'),
(3, 'Amit', '11A', 'Vadodara'),
(4, 'Neha', '11B', 'Rajkot'),
(5, 'Karan', '12A', 'Ahmedabad');

    -- Insert 3 Courses
INSERT INTO courses (course_id, course_name, monthly_fee)
VALUES
(101, 'Java Programming', 2500),
(102, 'Python Programming', 1500),
(103, 'Web Development', 800);

-- Insert 10 Payments
INSERT INTO payments (student_id, course_id, amount, paid_on)
VALUES
(1, 101, 2500, '2026-01-05'),
(2, 102, 1500, '2026-01-08'),
(3, 103, 800, '2026-01-12'),
(4, 101, 2500, '2026-01-15'),
(5, 102, 1500, '2026-01-20'),
(1, 103, 800, '2026-02-03'),
(2, 101, 2500, '2026-02-07'),
(3, 102, 1500, '2026-02-10'),
(4, 103, 800, '2026-02-15'),
(5, 101, 2500, '2026-02-20');


-- Update Course Fee
UPDATE courses
SET monthly_fee = 2000
WHERE course_id = 102;


-- Delete One Payment
DELETE FROM payments
WHERE payment_id = 10;


-- Display Payment Details Using JOIN
SELECT
    students.name AS student_name,
    courses.course_name,
    payments.amount,
    payments.paid_on
FROM payments
JOIN students
    ON payments.student_id = students.student_id
JOIN courses
    ON payments.course_id = courses.course_id
ORDER BY payments.paid_on ASC;


