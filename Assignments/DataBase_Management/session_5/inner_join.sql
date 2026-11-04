SELECT
    s.student_name,
    sub.subject_name,
    m.marks_obtained,
    sub.max_marks
FROM students AS s
INNER JOIN marks AS m
    ON s.roll_no = m.roll_no
INNER JOIN subjects AS sub
    ON m.subject_id = sub.subject_id
WHERE s.roll_no = 1
ORDER BY sub.subject_name ASC;