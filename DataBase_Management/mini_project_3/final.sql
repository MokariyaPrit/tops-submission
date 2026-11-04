DROP PROCEDURE IF EXISTS monthly_fee_summary;

DROP PROCEDURE IF EXISTS monthly_fee_summary;

DELIMITER $$

CREATE PROCEDURE monthly_fee_summary(
    IN p_month INT,
    IN p_year INT
)
BEGIN

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

    SELECT SUM(amount) AS grand_total
    FROM payments
    WHERE MONTH(paid_on) = p_month
      AND YEAR(paid_on) = p_year;

END $$

DELIMITER ;

CALL monthly_fee_summary(1, 2026);

CALL monthly_fee_summary(2, 2026);



-- Hand calculation:
-- 2500 + 1500 + 800 + 2500 + 1500 = 8800
-- Expected grand total = 8800

-- Hand calculation after deleting payment_id 10:
-- 800 + 2500 + 1500 + 800 = 5600
-- Expected grand total = 5600

