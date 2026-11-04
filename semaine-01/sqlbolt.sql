-- Exercices from SQLBolt: https://sqlbolt.com/lesson/select_queries_introduction

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

-- Lesson 2: Queries whith constraints (Pt. 1)
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

-- Lesson 3: Queries whith constraints (Pt. 2)
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