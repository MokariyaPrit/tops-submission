--Students of class 10A sorted by name
SELECT roll_no, student_name, class
FROM students
WHERE class = '10A'
ORDER BY student_name ASC;


--Marks of 80 or more, highest first
SELECT roll_no, subject_id, marks_obtained AS marks
FROM marks
WHERE marks_obtained >= 80
ORDER BY marks_obtained DESC;


-- Three highest marks
SELECT roll_no, subject_id, marks_obtained AS highest_marks
FROM marks
ORDER BY marks_obtained DESC
LIMIT 3;


-- Display all student names
SELECT student_name AS student_name
FROM students;