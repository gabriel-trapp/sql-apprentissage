-- AUTO-TEST SQL (8 requêtes, 1 h maximum)
-- Tables SQLZoo (world, teacher, dept, movie, actor, casting) et Mode (benn.college_football_players)

-- SQLZoo, table world(name, continent, area, population, gdp)

-- 1. Les 5 pays d'Europe ou d'Asie les plus peuplés parmi ceux de plus de
--    50 millions d'habitants : afficher le nom et la population, du plus peuplé au moins peuplé.
SELECT name, population
FROM world
WHERE population > 50000000 AND (continent = 'Europe' OR continent = 'Asia')
ORDER BY population DESC
LIMIT 5;

-- 2. Pour chaque continent : le nombre de pays, la population totale et le PIB moyen
--    arrondi à l'entier. Garder uniquement les continents de plus de 10 pays.
SELECT continent, COUNT(name) AS num_countries, SUM(population) AS total_population, ROUND(AVG(gdp), 0) AS pib_moyen
FROM world
GROUP BY continent
HAVING COUNT(name) > 10;

-- 3. Classer les pays par taille : 'Large' si population >= 100 millions,
--    'Medium' si >= 10 millions, 'Small' sinon. Afficher le nombre de pays dans chaque catégorie.
SELECT CASE WHEN population >= 100000000 THEN 'Large'
        WHEN population >= 10000000 THEN 'Medium'
        ELSE 'Small' END AS size_group,
        COUNT(*) AS num_countries
FROM world
GROUP BY 1;

-- SQLZoo, tables teacher(id, dept, name, phone, mobile) et dept(id, name)

-- 4. Pour chaque département, afficher son nom et son nombre de professeurs,
--    y compris les départements sans aucun professeur (qui doivent afficher 0).
SELECT d.id, d.name, COUNT(t.name) AS num_prof
FROM dept d
LEFT JOIN teacher t ON d.id = t.dept
GROUP BY d.id, d.name;

-- 5. Les professeurs sans département OU sans numéro de mobile : afficher leur nom
--    et leur mobile, avec 'N/A' à la place du NULL.
SELECT name, COALESCE(mobile, 'N/A') AS mobile2
FROM teacher
WHERE mobile IS NULL OR dept is NULL;

-- SQLZoo, tables movie(id, title, yr), actor(id, name), casting(movieid, actorid, ord)

-- 6. Les 5 films qui ont le plus d'acteurs : titre, année et nombre d'acteurs.
--    En cas d'égalité, ordre alphabétique des titres.
SELECT m.title, m.yr, COUNT(c.actorid) AS num_actors
FROM movie m
JOIN casting c ON m.id = c.movieid
GROUP BY m.id, m.title, m.yr
ORDER BY num_actors DESC, title ASC
LIMIT 5;

-- SQLZoo, table world, avec WITH

-- 7. Les continents dont la population totale est supérieure à la population totale
--    moyenne des continents. Utiliser une CTE (WITH).
WITH population_continent AS (
    SELECT continent, SUM(population) AS total_population
    FROM world
    GROUP BY continent)
SELECT continent
FROM population_continent
WHERE total_population > (SELECT AVG(total_population) FROM population_continent); 

-- SQLZoo, table nobel(yr, subject, winner)

-- 8. Pour chaque discipline (subject) : le nombre total de prix, le nombre de prix
--    attribués depuis 2000 (yr >= 2000) et leur pourcentage du total arrondi à
--    1 décimale. Garder les disciplines avec au moins 50 prix, du pourcentage le
--    plus élevé au plus bas.
SELECT subject, 
       COUNT(winner) AS nb_prix,
       SUM(CASE WHEN yr >= 2000 THEN 1 ELSE 0 END) AS nb_prix_2000,
       ROUND(SUM(CASE WHEN yr >= 2000 THEN 1 ELSE 0 END) * 100.0 / COUNT(winner), 1) AS pct_prix_2000
FROM nobel
GROUP BY subject
HAVING COUNT(subject) >= 50
ORDER by 4 DESC;
