    use school_db;
SELECT roll_no, name, class
FROM students
WHERE class = '10A'
ORDER BY student_name ASC;


SELECT roll_no, subject_id, marks_obtained AS marks
FROM marks
WHERE marks_obtained >= 80
ORDER BY marks_obtained DESC;



SELECT roll_no, subject_id, marks_obtained AS highest_marks
FROM marks
ORDER BY marks_obtained DESC
LIMIT 3;

SELECT student_name AS student_name
FROM students;

SELECT subject_id,
       ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks
GROUP BY subject_id;



SELECT roll_no,
       SUM(marks_obtained) AS total_marks
FROM marks
GROUP BY roll_no
ORDER BY total_marks DESC;



SELECT subject_id,
       COUNT(*) AS total_marks_rows
FROM marks
GROUP BY subject_id;

SELECT SUM(marks_obtained) AS total_marks
FROM marks
WHERE roll_no = 1;

SELECT ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks
WHERE subject_id = 1;

SELECT COUNT(*) AS total_students
FROM students
WHERE class = '10A';

SELECT roll_no,
       SUM(marks_obtained) AS total_marks
FROM marks
GROUP BY roll_no
ORDER BY total_marks DESC
LIMIT 1;