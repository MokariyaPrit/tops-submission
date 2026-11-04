--Topper query
    SELECT roll_no,
        SUM(marks_obtained) AS total_marks
    FROM marks
    GROUP BY roll_no
    ORDER BY total_marks DESC
    LIMIT 1;