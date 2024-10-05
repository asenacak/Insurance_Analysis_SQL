-- Customer Profile Analysis
-- 1) Age vs Insurance Premium Analysis
---- Calculate age distribution statistics to decide on age groups
SELECT 
  COUNT(age_in_years) AS n,
  MIN(age_in_years) AS min,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age_in_years) AS q1, -- lower quartile
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age_in_years) AS median, -- median age
  AVG(age_in_years) AS mean, -- average age
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age_in_years) AS q3, -- upper quartile
  MAX(age_in_years) AS max, -- maximum age
  STDDEV(age_in_years) AS sd -- standard deviation
FROM customer
WHERE age_in_years IS NOT NULL;

---- Analyze how insurance premiums vary across different age groups
SELECT 
  CASE
    WHEN age_in_years <= 35 THEN 'Under 35 or Young'
    WHEN age_in_years BETWEEN 36 AND 55 THEN '36-55 or Middle-Aged'
    WHEN age_in_years BETWEEN 56 AND 75 THEN '56-75 or Older'
    ELSE 'Over 75 or Seniors'
  END AS age_groups,
  COUNT(*) AS count,
  AVG(curr_ann_prem) AS annual_premium
FROM customer
GROUP BY age_groups
ORDER BY annual_premium;

-- 2) College Degree (Education) vs Insurance Premium
---- Analyze the impact of having a college degree on insurance premiums
SELECT
  CASE 
    WHEN d.college_degree = 1 THEN 'Yes'
    ELSE 'No'
  END AS degree,
  COUNT(*) AS count,
  AVG(c.curr_ann_prem) AS mean_annual_premium
FROM demographic d
INNER JOIN customer c ON d.individual_id = c.individual_id
GROUP BY degree;

-- 3) Having Children vs Insurance Premium
---- Analyze how having children affects insurance premiums
SELECT 
  CASE
    WHEN d.has_children = 1 THEN 'Yes'
    ELSE 'No'
  END AS children,
  COUNT(*) AS count,
  AVG(c.curr_ann_prem) AS annual_premium
FROM demographic d
INNER JOIN customer c ON d.individual_id = c.individual_id
GROUP BY children;

-- 4) Marital Status vs Insurance Premium
--- Check for null values in marital status
SELECT COUNT(*)
FROM demographic
WHERE marital IS NULL; -- 431648 rows are null

---- Analyze how insurance premiums vary according to marital status
SELECT 
  d.marital,
  COUNT(*) AS count,
  AVG(c.curr_ann_prem) AS annual_premium
FROM demographic d
INNER JOIN customer c ON d.individual_id = c.individual_id
WHERE d.marital IS NOT NULL
GROUP BY d.marital;

-- 5) Being a Home Owner vs Insurance Premium
---- Analyze how insurance premiums differ based on home ownership status
SELECT 
  CASE
    WHEN d.home_owner = 1 THEN 'Yes'
    ELSE 'No'
  END AS owner,
  COUNT(*) AS count,
  AVG(c.curr_ann_prem) AS annual_premium
FROM demographic d
INNER JOIN customer c ON d.individual_id = c.individual_id
GROUP BY d.home_owner;

-- 6) Income Level vs Insurance Premium
---- Calculate income distribution statistics to determine income groups
SELECT
 COUNT(*) AS n,
 MIN(income) AS min,
 PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY income) AS q1,
 PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY income) AS median,
 AVG(income) AS mean,
 PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY income) AS q3,
 MAX(income) AS max,
 STDDEV(income) AS sd
FROM demographic
WHERE income IS NOT NULL;

-- Analyze how insurance premiums vary according to household income levels
SELECT
  CASE 
    WHEN d.income <= 47500 THEN 'Low Income'
    WHEN d.income BETWEEN 47501 AND 87500 THEN 'Middle Income'
    WHEN d.income > 87500 THEN 'High Income'
  END AS income_groups,
  COUNT(*) AS count,
  AVG(c.curr_ann_prem) AS annual_premium
FROM demographic d
INNER JOIN customer c ON d.individual_id = c.individual_id
GROUP BY income_groups
ORDER BY annual_premium;
