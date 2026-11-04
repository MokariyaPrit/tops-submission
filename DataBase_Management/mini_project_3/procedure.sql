
-- Stored Procedure: Monthly Fee Summary

DELIMITER $$

CREATE PROCEDURE monthly_fee_summary(
    IN p_month INT,
    IN p_year INT
)
BEGIN

    -- Course-wise payment summary
    SELECT
        c.course_name,
        COUNT(p.payment_id) AS number_of_payments,
        SUM(p.amount) AS total_collected
    FROM payments p
    JOIN courses c
        ON p.course_id = c.course_id
    WHERE MONTH(p.paid_on) = p_month
      AND YEAR(p.paid_on) = p_year
    GROUP BY c.course_id, c.course_name;

    -- Grand Total in separate SELECT
    SELECT
        SUM(amount) AS grand_total
    FROM payments
    WHERE MONTH(paid_on) = p_month
      AND YEAR(paid_on) = p_year;

END $$

DELIMITER ;



-- Call procedure for January 2026
CALL monthly_fee_summary(1, 2026);

-- Call procedure for February 2026
CALL monthly_fee_summary(2, 2026);