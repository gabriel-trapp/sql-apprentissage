-- Exercises from LeetCode: https://leetcode.com/studyplan/top-sql-50/

-- Select
-- 1.
SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y';
-- 2.
SELECT name
FROM customer
WHERE referee_id != 2 OR  referee_id IS NULL;
-- 3.
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000;
-- 4.
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY author_id ASC;
-- 5.
SELECT tweet_id 
FROM tweets
WHERE LENGTH(content) > 15;

-- Basic Joins
-- 1.
SELECT unique_id, name
FROM employeeUNI
RIGHT JOIN employees ON employeeUNI.id = employees.id;
-- 2.
SELECT product_name, year, price
FROM product
JOIN sales ON product.product_id = sales.product_id;
-- 3.
SELECT customer_id, COUNT(visit_id) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
GROUP BY customer_id;
-- 4.
SELECT id
FROM weather x
WHERE temperature > (SELECT temperature FROM weather y WHERE y.recordDATE = DATE_SUB(x.recordDate, INTERVAL 1 DAY));
-- 5.
SELECT a1.machine_id, ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2 ON a1.machine_id = a2.machine_id AND a1.process_id = a2.process_id
WHERE a1.activity_type = 'start' AND a2.activity_type = 'end'
GROUP BY a1.machine_id;
-- 6.
SELECT name, bonus
FROM employee
LEFT JOIN bonus ON employee.empId = bonus.empId
WHERE bonus < 1000 or bonus IS NULL;
-- 7.
SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.student_id) AS attended_exams
FROM students s
CROSS JOIN subjects sub 
LEFT JOIN examinations e ON e.student_id = s.student_id AND e.subject_name = sub.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
--  8.
SELECT name
FROM employee
WHERE id IN (SELECT managerId 
                FROM employee 
                GROUP BY managerId 
                HAVING COUNT(employee.managerId) >= 5);
-- 9.
SELECT 
    s.user_id,
    ROUND(IFNULL(SUM(c.action = 'confirmed') / COUNT(c.action), 0), 2) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;

-- Basic Aggregation Functions
-- 1.
SELECT *
FROM cinema
WHERE id % 2 != 0 AND description NOT IN ("boring")
ORDER BY rating DESC;

-- 2.
SELECT p.product_id, IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

-- 3.
SELECT project_id, ROUND(SUM(experience_years) / COUNT(name), 2) AS average_years
FROM project
LEFT JOIN employee ON project.employee_id = employee.employee_id
GROUP BY 1;

-- 4.
SELECT contest_id, ROUND(COUNT(register.user_id) * 100 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM register
GROUP BY 1
ORDER BY 2 DESC, 1  ;

-- 5.
SELECT query_name, 
       ROUND(SUM(rating / position) / COUNT(rating), 2) AS quality, 
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(rating), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;

-- 6.
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(trans_date) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY 1, 2;

-- 7.
WITH lll AS (SELECT * FROM delivery x WHERE x.order_date <= ALL(SELECT order_date FROM delivery y WHERE x.customer_id = y.customer_id))
SELECT ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS immediate_percentage
FROM lll;

-- 8.
WITH lll AS (
    SELECT * 
    FROM Activity x 
    WHERE event_date = DATE_ADD(
        (SELECT MIN(event_date) FROM Activity y WHERE x.player_id = y.player_id), 
        INTERVAL 1 DAY
    )
)
SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM lll;
