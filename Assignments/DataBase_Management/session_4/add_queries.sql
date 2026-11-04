--Total marks of roll number 1 (SUM)
SELECT SUM(marks_obtained) AS total_marks
FROM marks
WHERE roll_no = 1;


--Average marks of subject 1 (AVG)
SELECT ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks
WHERE subject_id = 1;


-- Number of students in class 10A (COUNT)
SELECT COUNT(*) AS total_students
FROM students
WHERE class = '10A';