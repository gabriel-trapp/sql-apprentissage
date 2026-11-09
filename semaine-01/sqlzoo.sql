-- Exercises from SQLZoo: https://sqlzoo.net

-- SELECT basics
-- 1.
SELECT population FROM world 
WHERE name = 'Germany';
-- 2.
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- 3.
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;

-- SELECT from WORLD
-- 1.
SELECT name, continent, population FROM world;
-- 2.
SELECT name FROM world
WHERE population > 200000000;
-- 3.
SELECT name, GDP/population FROM world
WHERE population > 200000000;
-- 4.
SELECT name, population/1000000 FROM world
WHERE continent = "South America";
-- 5.
SELECT name, population FROM world
WHERE name IN ("France", "Germany", "Italy");
-- 6.
SELECT name FROM world
WHERE name LIKE "%United%";
-- 7.
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;
-- 8.
SELECT name, population, area FROM world
WHERE area > 3000000 XOR population > 250000000;
-- 9.
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world
WHERE continent = "South America";
-- 10.
SELECT name, ROUND(GDP/population, -3) FROM world
WHERE GDP > 1000000000000;
-- 11.
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);
-- 12.
SELECT name, capital FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;
-- 13.
SELECT name FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %';

--SELECT from Nobel
-- 1.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;
-- 2.
SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature';
-- 3.
Select yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';
-- 4.
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;
-- 5.
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'literature' AND yr BETWEEN 1980 AND 1989;
-- 6.
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
-- 7.
SELECT winner
FROM nobel
WHERE winner LIKE "John%";
-- 8.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'physics' AND yr = 1980) OR (subject = 'chemistry' AND yr = 1984);
-- 9.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('chemistry', 'medicine');
-- 10.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);
-- 11.
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';
-- 12.
SELECT *
FROM nobel
WHERE winner = 'EUGENE O''NEILL';
-- 13.
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;
-- 14.
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('chemistry', 'physics'), subject, winner;

-- SELECT in SELECT
-- 1.
SELECT name 
FROM world
WHERE population > (SELECT population FROM world WHERE name='Russia');
-- 2.
SELECT name 
FROM world
WHERE GDP/population > (SELECT GDP/ population FROM world WHERE name='United Kingdom') AND continent = 'Europe';
-- 3.
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;
-- 4.
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom') AND population < (SELECT population FROM world WHERE name = 'Germany');
-- 5.
SELECT name, CONCAT(ROUND(population * 100 / (SELECT population FROM world WHERE name = 'Germany')), '%') AS percentage
FROM world
WHERE continent = 'Europe';
-- 6.
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe');
-- 7.
SELECT continent, name, area
FROM world x
WHERE area >= ALL(SELECT area FROM world y WHERE y.continent=x.continent AND area>0);
-- 8.
SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name FROM world yWHERE y.continent = x.continent);
-- 9.
SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL(SELECT population FROM world y WHERE y.continent = x.continent);
-- 10.
SELECT name, continent
FROM world x
WHERE population/3 > ALL(SELECT population FROM world y WHERE y.continent = x.continent AND y.name <> x.name);

-- SUM and COUNT
-- 1.
SELECT SUM(population)
FROM world;
-- 2.
SELECT DISTINCT continent
FROM world;
-- 3.
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';
-- 4.
SELECT COUNT(name)
FROM world
WHERE area >  1000000;
-- 5.
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');
--  6.
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;
-- 7.
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent;
-- 8.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;

-- The JOIN
-- 1.
SELECT game,team,player,gtime
FROM goal 
WHERE player = 'Leandro Trossard';
-- 2.
SELECT id, teamname, coach
FROM team
WHERE id = 'BEL';
-- 3.
SELECT player, gtime, teamname
FROM goal JOIN team ON goal.team=team.id
WHERE gtime < 8;
-- 4.
SELECT player, teamname, coach
 FROM goal JOIN team ON goal.team=team.id
 WHERE coach LIKE 'Sébastien%';
-- 5.
SELECT player, id, city
FROM goal JOIN game ON goal.game=game.id
WHERE player = 'Harry Edward Kane';
-- 6.
SELECT player, team
FROM goal JOIN game ON (id = game)
WHERE city = 'Vancouver';
-- 7.
SELECT player, teamname
FROM goal 
JOIN game ON (id = game)
JOIN team ON (team = team.id)
WHERE city = 'Vancouver';
-- 8.
SELECT city, teamname
FROM game
JOIN team ON (team.id = game.team1 OR team.id = game.team2)
WHERE played = '2026-07-01';
-- 9.
SELECT teamname, player
FROM game
JOIN goal ON (game.id = goal.game)
JOIN team ON (goal.team = team.id)
WHERE played = '2026-07-02';
-- 10.
SELECT played, goal.player, pos
FROM game
JOIN goal ON (game.id = goal.game)
JOIN player ON (goal.player = player.playername)
WHERE city = 'Mexico City';
-- 11.
SELECT player.playername, team.teamname
FROM goal
JOIN player ON (goal.player = player.playername)
JOIN team ON (player.team = team.id)
WHERE pos = 'DEF';
-- 12.
SELECT player, pos, teamname, city
FROM goal
JOIN player ON (goal.player = player.playername)
JOIN team ON (player.team = team.id)
JOIN game ON (goal.game = game.id)
WHERE gtime BETWEEN 91 AND 120;

-- More JOIN Operations
-- 1.
SELECT id, title
 FROM movie
 WHERE yr=1962 AND budget >2000000;
 -- 2.
 SELECT yr
FROM movie
WHERE title = 'Citizen Kane';
-- 3.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%';
-- 4.
SELECT id
FROM actor
WHERE name = 'Glenn Close';
-- 5.
SELECT id
FROM movie
WHERE title = 'Casablanca' AND yr = 1942;
-- 6.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE movieid = 11768;
-- 7.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE title = 'Alien';
-- 8.
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'Harrison Ford';
-- 9.
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'Harrison Ford' AND ord != 1;
-- 10.
SELECT title, name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE yr = 1962 AND ord = 1;
-- 11.
SELECT yr, COUNT(title)
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
-- 12.
WITH s AS (SELECT movieid
           FROM casting
           JOIN actor ON casting.actorid = actor.id
           WHERE name = 'Julie Andrews')
SELECT title, name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (SELECT movieid FROM s) AND ord = 1;
-- 13.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(*) >= 15
ORDER BY name;
-- 14.
SELECT title, COUNT(actorid)
FROM movie
JOIN casting ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;
-- 15.
WITH s AS (SELECT movieid 
           FROM casting
           JOIN actor ON casting.actorid = actor.id
           WHERE name = 'Art Garfunkel')
SELECT DISTINCT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE movieid IN (SELECT movieid FROM s) AND name != 'Art Garfunkel';

-- Using NULL
-- 1.
SELECT name
FROM teacher 
WHERE dept IS NULL;
-- 2.
SELECT teacher.name, dept.name
FROM teacher 
INNER JOIN dept ON (teacher.dept=dept.id);
-- 3.
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id);
-- 4.
SELECT teacher.name, dept.name
 FROM teacher
 RIGHT JOIN dept ON (teacher.dept=dept.id)
-- 5.
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher;
-- 6.
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id;
-- 7.
SELECT COUNT(name), COUNT(mobile)
FROM teacher;
-- 8.
SELECT dept.name, COUNT(teacher.name)
FROM teacher 
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;
--  9.
SELECT name, CASE
             WHEN dept IN ('1','2') THEN 'Sci'
             ELSE 'Art' END AS l
FROM teacher;
-- 10.
SELECT name, CASE
             WHEN dept IN ('1','2') THEN 'Sci'
             WHEN dept = 3 THEN 'Art'
             ELSE 'None' END AS l
FROM teacher;
