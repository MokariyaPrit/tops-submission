SELECT
    sub.subject_id,
    sub.subject_name,
    COUNT(m.marks_id) AS total_marks_recorded
FROM marks AS m
RIGHT JOIN subjects AS sub
    ON m.subject_id = sub.subject_id
GROUP BY sub.subject_id, sub.subject_name
ORDER BY sub.subject_id;