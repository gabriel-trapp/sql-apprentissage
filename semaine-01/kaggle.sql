-- Exercises from Kaggle Intro to SQL: https://www.kaggle.com/learn/intro-to-sql

-- Lesson 2: Select, From & Where
-- 1.
SELECT country
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE unit = 'ppm'

-- 2.
SELECT *
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE value = 0

-- Lesson 3: Group By, Having & Count
-- 1.
SELECT `by` AS author, COUNT(*) AS NumPosts
FROM `bigquery-public-data.hacker_news.full`
GROUP BY author
HAVING COUNT(*) > 10000

-- 2.
SELECT COUNT(*) AS num_deleted
FROM `bigquery-public-data.hacker_news.full`
WHERE deleted = True

-- Lesson 4: Order By
-- 1.
SELECT country_name, AVG(value) AS avg_ed_spending_pct
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE indicator_code = 'SE.XPD.TOTL.GD.ZS' AND year >= 2010 AND year <= 2017
GROUP BY country_name
ORDER BY avg_ed_spending_pct DESC

-- Lesson 5: As & With
-- 3.
SELECT EXTRACT(YEAR FROM trip_start_timestamp) AS year, COUNT(1) AS num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
GROUP BY year
ORDER BY year

-- 4.
SELECT EXTRACT(MONTH FROM trip_start_timestamp) AS month, COUNT(1) AS num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE EXTRACT(YEAR FROM trip_start_timestamp) = 2016
GROUP BY month
ORDER BY month

-- 5.
WITH RelevantRides AS
(
    SELECT trip_start_timestamp, trip_miles, trip_seconds
    FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    WHERE trip_start_timestamp > '2016-01-01' AND
          trip_start_timestamp < '2016-04-01' AND
          trip_seconds > 0 AND
          trip_miles > 0
)
SELECT EXTRACT(HOUR FROM trip_start_timestamp) AS hour_of_day,
       COUNT(1) AS num_trips,
       3600 * SUM(trip_miles) / SUM(trip_seconds) AS avg_mph
FROM RelevantRides
GROUP BY hour_of_day
ORDER BY hour_of_day

-- Lesson 6: Joining Data
-- 3.
SELECT id, title, owner_user_id
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE tags LIKE '%bigquery%'

-- 4.
SELECT a.id, a.body, a.owner_user_id
FROM `bigquery-public-data.stackoverflow.posts_questions` AS q
INNER JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a
    ON q.id = a.parent_id
WHERE q.tags LIKE '%bigquery%'

-- 5.
SELECT a.owner_user_id AS user_id, COUNT(1) AS number_of_answers
FROM `bigquery-public-data.stackoverflow.posts_questions` AS q
INNER JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a
    ON q.id = a.parent_id
WHERE q.tags LIKE '%bigquery%'
GROUP BY a.owner_user_id