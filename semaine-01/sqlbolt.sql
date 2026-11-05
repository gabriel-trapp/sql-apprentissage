-- Exercises from SQLBolt: https://sqlbolt.com/lesson/select_queries_introduction


-- Lesson 1: SELECT queries 101
-- 1. 
SELECT title FROM movies; 
-- 2. 
SELECT director FROM movies; 
-- 3. 
SELECT title, director FROM movies;
-- 4. 
SELECT title, year FROM movies;
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
-- 2.
SELECT title, year FROM movies
ORDER BY year DESC
LIMIT 4;
-- 3.
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5;
-- 4.
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
LIMIT 2 OFFSET 2;


-- Lesson 6: Multi-table queries with JOINs
-- 1.
SELECT title, domestic_sales, international_sales FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;
-- 2.
SELECT title, domestic_sales, international_sales FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;
-- 3.
SELECT title, rating FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
ORDER BY rating DESC;


-- Lesson 7: Outer JOINs
-- 1.
SELECT DISTINCT building FROM employees;
-- 2.
SELECT * FROM buildings;
-- 3.
SELECT DISTINCT building_name, role FROM buildings
LEFT JOIN employees ON buildings.building_name = employees.building;


-- Lesson 8: A short note on NULLs
-- 1.
SELECT name, role FROM employees
WHERE building IS NULL;
-- 2.
SELECT DISTINCT building_name FROM buildings
LEFT JOIN employees ON buildings.building_name = employees.building
WHERE name IS NULL;


-- Lesson 9: Queries with expressions
-- 1.
SELECT title, (domestic_sales + international_sales) / 1000000 AS combined_sales FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;
-- 2.
SELECT title, rating * 10 AS rating_in_percent FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;
-- 3.
SELECT title FROM movies
WHERE year % 2 = 0;


-- Lesson 10: Queries with aggregates (Pt. 1)
-- 1.
SELECT MAX(years_employed) FROM employees;
-- 2.
SELECT role, AVG(years_employed) AS average_years_employed FROM employees
GROUP BY role;
-- 3.
SELECT building, SUM(years_employed) AS total_years_employed FROM employees
GROUP BY building;


-- Lesson 11: Queries with aggregates (Pt. 2)
-- 1.
SELECT role, COUNT(*) AS number_of_artists FROM employees
WHERE role = "Artist";
-- 2.
SELECT role, COUNT(*) AS number_of_employees FROM employees
GROUP BY role;
-- 3.
SELECT role, SUM(years_employed) AS total_years_employed FROM employees
GROUP BY role
HAVING role = "Engineer";


-- Lesson 12: Order of execution of a Query
-- 1.
SELECT director, COUNT(*) AS number_of_movies FROM movies
GROUP BY Director;
-- 2.
SELECT director, SUM(domestic_sales + international_sales) AS total_sales FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
GROUP BY Director;