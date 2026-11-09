-- Exercises from Mode SQL Tutorial: https://mode.com/sql-tutorial

-- SQL CASE
-- 1.
SELECT player_name,
       state,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL END AS is_from_california
    FROM benn.college_football_players
ORDER BY is_from_california ASC;
-- 2.
SELECT player_name,
        height,
        CASE WHEN height > 75 THEN 'over 75'
             WHEN height > 71 AND height <= 75 THEN '72-75'
             WHEN height > 67 AND height <= 71 THEN '68-71'
             ELSE 'under 68' END AS height_group
    FROM benn.college_football_players;
-- 3.
SELECT *,
       CASE WHEN year IN ('JR', 'SR') THEN 'junior_or_senior'
            ELSE NULL END AS class_group
    FROM benn.college_football_players;
-- 4.
SELECT CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' END AS regional_designation,
        COUNT(*) AS players
    FROM benn.college_football_players
WHERE weight >= 300
GROUP BY regional_designation;
-- 5.
SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(*) AS total_players
    FROM benn.college_football_players
 GROUP BY state
 ORDER BY total_players DESC;
-- 6.
SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL END AS school_name_group,
       COUNT(*) AS players
    FROM benn.college_football_players
GROUP BY school_name_group;

--SQL DATE FORMAT
-- 1.
SELECT companies.category_code,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '3 years'
                       THEN 1 ELSE NULL END) AS acquired_3_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '5 years'
                       THEN 1 ELSE NULL END) AS acquired_5_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '10 years'
                       THEN 1 ELSE NULL END) AS acquired_10_yrs,
       COUNT(1) AS total
FROM tutorial.crunchbase_companies_clean_date companies
JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions ON acquisitions.company_permalink = companies.permalink
WHERE founded_at_clean IS NOT NULL
GROUP BY 1
ORDER BY 5 DESC