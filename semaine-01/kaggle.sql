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

-- Exercises from Kaggle Advanced SQL: https://www.kaggle.com/learn/advanced-sql

-- Lesson 1 : JOINs and UNIONs
-- 1.
SELECT q.id AS q_id, MIN(TIMESTAMP_DIFF(a.creation_date, q.creation_date, SECOND)) AS time_to_answer
FROM `bigquery-public-data.stackoverflow.posts_questions` AS q
LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a ON q.id = a.parent_id
WHERE q.creation_date >= '2018-01-01' and q.creation_date < '2018-02-01'
GROUP BY q_id
ORDER BY time_to_answer

-- 2.
SELECT q.owner_user_id AS owner_user_id, MIN(q.creation_date) AS q_creation_date, MIN(a.creation_date) AS a_creation_date
FROM `bigquery-public-data.stackoverflow.posts_questions` AS q
FULL JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a ON q.owner_user_id = a.owner_user_id 
WHERE q.creation_date >= '2019-01-01' AND q.creation_date < '2019-02-01' AND a.creation_date >= '2019-01-01' AND a.creation_date < '2019-02-01'
GROUP BY owner_user_id

-- 3. 
SELECT u.id AS id, MIN(q.creation_date) AS q_creation_date, MIN(a.creation_date) AS a_creation_date
FROM `bigquery-public-data.stackoverflow.users` AS u
LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` AS q ON u.id = q.owner_user_id
LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` AS a ON u.id = a.owner_user_id
WHERE u.creation_date >= '2019-01-01' AND u.creation_date < '2019-02-01'
GROUP BY id

-- 4. 
SELECT owner_user_id 
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE EXTRACT(DATE FROM creation_date) = '2019-01-01'
UNION DISTINCT
SELECT owner_user_id 
FROM `bigquery-public-data.stackoverflow.posts_answers`
WHERE EXTRACT(DATE FROM creation_date) = '2019-01-01'

-- Lesson 2 : Analytic Functions
-- 1.
SELECT trip_date, AVG(num_trips) OVER (ORDER BY trip_date ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING) AS avg_num_trips
FROM (SELECT DATE(trip_start_timestamp) AS trip_date, COUNT(1) AS num_trips
      FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
      WHERE trip_start_timestamp >= '2016-01-01' AND trip_start_timestamp < '2016-04-01'
      GROUP BY trip_date)
ORDER BY trip_date

-- 2. 
SELECT pickup_community_area, trip_start_timestamp, trip_end_timestamp, RANK() OVER (PARTITION BY pickup_community_area ORDER BY trip_start_timestamp) AS trip_number
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE DATE(trip_start_timestamp) = '2013-10-03'

-- 3.
SELECT taxi_id, trip_start_timestamp, trip_end_timestamp, TIMESTAMP_DIFF(trip_start_timestamp, LAG(trip_end_timestamp, 1) OVER (PARTITION BY taxi_id ORDER BY trip_start_timestamp), MINUTE) AS prev_break
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE DATE(trip_start_timestamp) = '2013-10-03' 

-- Lesson 3 : Nested and Repeated Data
-- 1. 
SELECT committer.name AS committer_name, COUNT(*) AS num_commits
FROM `bigquery-public-data.github_repos.sample_commits`
WHERE committer.date >= '2016-01-01' AND committer.date < '2017-01-01'
GROUP BY committer_name
ORDER BY num_commits DESC

--2.
num_rows = 6

-- 3.
SELECT l.name as language_name, COUNT(*) as num_repos
FROM `bigquery-public-data.github_repos.languages`, UNNEST(language) AS l
GROUP BY language_name
ORDER BY num_repos DESC

-- 4.
SELECT l.name, l.bytes
FROM `bigquery-public-data.github_repos.languages`, UNNEST(language) as l
WHERE repo_name = 'polyrabbit/polyglot'
ORDER BY l.bytes DESC

-- Lesson 4 : Writing Efficient Queries
-- 1. 
query_to_optimize = 3

-- 2. 
WITH CurrentOwnersCostumes AS
(SELECT CostumeID 
FROM CostumeOwners 
WHERE OwnerID = MitzieOwnerID),
OwnersCostumesLocations AS
(SELECT cc.CostumeID, Timestamp, Location 
FROM CurrentOwnersCostumes cc 
INNER JOIN CostumeLocations cl ON cc.CostumeID = cl.CostumeID),
LastSeen AS
(SELECT CostumeID, MAX(Timestamp)
FROM OwnersCostumesLocations
GROUP BY CostumeID)
SELECT ocl.CostumeID, Location 
FROM OwnersCostumesLocations ocl 
INNER JOIN LastSeen ls ON ocl.timestamp = ls.timestamp AND ocl.CostumeID = ls.costumeID