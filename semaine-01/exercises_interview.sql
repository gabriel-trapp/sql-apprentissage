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
SELECT unique_id, name
FROM employeeUNI
RIGHT JOIN employees ON employeeUNI.id = employees.id;
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

