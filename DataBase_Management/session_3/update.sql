-- Promote students from 9A to 10A
UPDATE students
SET class = '10A'
WHERE class = '9A';

SELECT * FROM students
WHERE class = '10A';

-- update one student
UPDATE students
SET city = 'Gandhinagar'
WHERE roll_no = 1;

SELECT * FROM students
WHERE roll_no = 1;

-- Add 5 grace marks to one marks row
UPDATE marks
SET marks_obtained = marks_obtained + 5
WHERE marks_id = 1;

SELECT * FROM marks
WHERE marks_id = 1;