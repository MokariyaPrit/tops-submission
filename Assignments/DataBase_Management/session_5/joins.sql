USE school_db;

--Add the two foreign keys
ALTER TABLE marks
ADD CONSTRAINT fk_marks_student
FOREIGN KEY (roll_no)
REFERENCES students(roll_no);

ALTER TABLE marks
ADD CONSTRAINT fk_marks_subject
FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id);


--Try inserting an invalid marks row
-- Run this query separately:
INSERT INTO marks (roll_no, subject_id, marks_obtained)
VALUES (99, 1, 75);

SHOW CREATE TABLE marks;
