--- Note: The data includes only one state (Texas).
-- 1) Analyze the top 10 cities with the highest average insurance premiums.
SELECT 
 a.city,
 a.county,
 AVG(curr_ann_prem) AS premium
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.city IS NOT NULL
GROUP BY a.city, a.county
ORDER BY premium DESC
LIMIT 10;


-- 2) Analyze the 10 cities with the lowest average insurance premiums.
SELECT 
 a.city,
 a.county,
 AVG(curr_ann_prem) AS premium
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.city IS NOT NULL
GROUP BY a.city, a.county
ORDER BY premium
LIMIT 10;


-- 3) Analyze how insurance premiums vary across different counties.
SELECT 
 a.county,
 AVG(curr_ann_prem) AS premium
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.county IS NOT NULL
GROUP BY a.county
ORDER BY premium;


-- 4) Analyze the relationship between the ranking of cities based on average income and insurance premiums.
-- This query ranks cities based on their average income and insurance premiums.
-- It then analyzes the relationship between the two rankings to understand
-- whether cities with higher average incomes tend to have higher insurance premiums.
WITH inc_prem AS (
   SELECT 
     a.city,
     ROUND(CAST(AVG(d.income) AS numeric), 2) AS avg_income,
     ROUND(CAST(AVG(c.curr_ann_prem) AS numeric), 2)  AS avg_premium
   FROM customer c
   INNER JOIN address a ON c.address_id = a.address_id
   INNER JOIN demographic d ON c.individual_id = d.individual_id
   WHERE d.income IS NOT NULL AND a.city IS NOT NULL
   GROUP BY a.city
)
SELECT 
  city, 
  avg_income, 
  avg_premium,
  RANK() OVER (ORDER BY avg_income DESC) AS income_rank,
  RANK() OVER (ORDER BY avg_premium DESC) AS premium_rank
FROM inc_prem;


-- 5) Calculate the correlation between average income and insurance premiums across cities.
WITH inc_prem AS (
   SELECT 
     a.city,
     AVG(d.income) AS avg_income,
     AVG(c.curr_ann_prem) AS avg_premium
   FROM customer c
   INNER JOIN address a ON c.address_id = a.address_id
   INNER JOIN demographic d ON c.individual_id = d.individual_id
   WHERE d.income IS NOT NULL AND a.city IS NOT NULL
   GROUP BY a.city
)
SELECT 
  CORR(avg_income, avg_premium) AS correlation_income_premium  -- Correlation between income and premium
FROM inc_prem;
--- corr: 0.70


-- 6) Find out which cities have the lowest average customer tenure (in days).
SELECT 
  a.city,
  a.county,
  AVG(c.days_tenure) AS avg_tenure
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.city IS NOT NULL
GROUP BY a.city, a.county
ORDER BY avg_tenure
LIMIT 10;


-- 7) Find out which cities have the highest average customer tenure (in days).
SELECT 
  a.city,
  a.county,
  AVG(c.days_tenure) AS avg_tenure
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.city IS NOT NULL
GROUP BY a.city, a.county
ORDER BY avg_tenure DESC
LIMIT 10;


-- 8) Analyze the variation in average customer tenure (in days) across different counties.
SELECT
  a.county,
  AVG(c.days_tenure) AS avg_tenure
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
WHERE a.county IS NOT NULL
GROUP BY a.county
ORDER BY avg_tenure;

