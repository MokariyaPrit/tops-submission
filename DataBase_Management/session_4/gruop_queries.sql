-- Average marks per subject
SELECT subject_id,
       ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks
GROUP BY subject_id;


-- Total marks per student, highest first
SELECT roll_no,
       SUM(marks_obtained) AS total_marks
FROM marks
GROUP BY roll_no
ORDER BY total_marks DESC;


--Number of marks rows per subject
SELECT subject_id,
       COUNT(*) AS total_marks_rows
FROM marks
GROUP BY subject_id;