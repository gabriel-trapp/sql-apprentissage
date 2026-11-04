-- Exercises from SQLBolt: https://sqlbolt.com/lesson/select_queries_introduction


-- Lesson 1: SELECT queries 101
-- 1. 
SELECT Title FROM movies; 
-- 2. 
SELECT Director FROM movies; 
-- 3. 
SELECT Title, Director FROM movies;
-- 4. 
SELECT Title, Year FROM movies;
-- 5. 
SELECT * FROM movies;


-- Lesson 2: Queries with constraints (Pt. 1)
-- 1. 
SELECT id, title FROM movies 
WHERE id = 6;
-- 2. 
SELECT title, year FROM movies
WHERE year BETWEEN 2000 AND 2010;
-- 3. 
SELECT title, year FROM movies
WHERE year NOT BETWEEN 2000 AND 2010;
-- 4. 
SELECT title, year FROM movies
WHERE year <= 2003;


-- Lesson 3: Queries with constraints (Pt. 2)
-- 1. 
SELECT title FROM movies 
WHERE title LIKE "Toy Story%";
-- 2. 
SELECT title, director FROM movies 
WHERE director = "John Lasseter";   
-- 3. 
SELECT title, director FROM movies 
WHERE director != "John Lasseter";
-- 4. 
SELECT title FROM movies 
WHERE title LIKE "WALL-_";


-- Lesson 4: Filtering and sorting Query results
-- 1.
SELECT DISTINCT director FROM movies
ORDER BY director ASC;
--2.
SELECT title, year FROM movies
ORDER BY year DESC
LIMIT 4;
--3.
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5;
--4.
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;


-- Lesson 5: SQL Review: Simple SELECT Queries
-- 1.
SELECT city, population FROM north_american_cities
WHERE country = "Canada";
-- 2.
SELECT city, latitude FROM north_american_cities
WHERE country = "United States"
ORDER BY LATITUDE DESC;
-- 3.
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;
-- 4.
SELECT city FROM north_american_cities
WHERE country = "Mexico"
ORDER BY population DESC
LIMIT 2;
-- 5.
SELECT city FROM north_american_cities
WHERE country = "United States"
ORDER BY population DESC
LIMIT 2 OFFSET 2
