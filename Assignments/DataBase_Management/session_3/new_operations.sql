
-- Show the first five marks rows before changes
SELECT * FROM marks
LIMIT 5;

--Insert one duplicate marks row on purpose
INSERT INTO marks (roll_no, subject_id, marks_obtained)
VALUES (1, 1, 90);

--Remove the duplicate using DELETE LIMIT 1
DELETE FROM marks
WHERE roll_no = 1
AND subject_id = 1
AND marks_obtained = 90
LIMIT 1;

--show the first 5 row again
SELECT * FROM marks
LIMIT 5;

--. Delete one student's marks rows

DELETE FROM marks
WHERE roll_no = 5;

--Delete that student
DELETE FROM students
WHERE roll_no = 5;

--Show the first five marks rows after deletion
SELECT * FROM marks
LIMIT 5;

--Check the students table
SELECT * FROM students;
