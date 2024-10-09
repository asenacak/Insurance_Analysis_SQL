-- 1) Count the total number of rows in the demographic table
SELECT COUNT(*)
FROM demographic;

-- 2) Analyze null and unique counts for each column in the demographic table
WITH null_counts AS (
  SELECT
   'Null Counts' AS demographic_data,
   SUM(CASE WHEN individual_id IS NULL THEN 1 ELSE 0 END) AS individual_id,
   SUM(CASE WHEN income IS NULL THEN 1 ELSE 0 END) AS income,
   SUM(CASE WHEN has_children IS NULL THEN 1 ELSE 0 END) AS has_children,
   SUM(CASE WHEN length_of_residence IS NULL THEN 1 ELSE 0 END) AS length_of_residence,
   SUM(CASE WHEN marital IS NULL THEN 1 ELSE 0 END) AS marital,
   SUM(CASE WHEN home_market_value IS NULL THEN 1 ELSE 0 END) AS home_market_value,
   SUM(CASE WHEN home_owner IS NULL THEN 1 ELSE 0 END) AS home_owner,
   SUM(CASE WHEN college_degree IS NULL THEN 1 ELSE 0 END) AS college_degree,
   SUM(CASE WHEN good_credit IS NULL THEN 1 ELSE 0 END) AS good_credit
  FROM demographic
),
unique_counts AS (
  SELECT
   'Unique Counts' AS demographic_data,
   COUNT(DISTINCT individual_id) AS individual_id,
   COUNT(DISTINCT income) AS income,
   COUNT(DISTINCT has_children) AS has_children,
   COUNT(DISTINCT length_of_residence) AS length_of_residence,
   COUNT(DISTINCT marital) AS marital,
   COUNT(DISTINCT home_market_value) AS home_market_value,
   COUNT(DISTINCT home_owner) AS home_owner,
   COUNT(DISTINCT college_degree) AS college_degree,
   COUNT(DISTINCT good_credit) AS good_credit
  FROM demographic
)
SELECT * FROM null_counts
UNION ALL
SELECT * FROM unique_counts;

-- 3) Check for unreasonable values in numeric columns
SELECT *
FROM demographic
WHERE income < 0
   OR length_of_residence < 0;

-- 4) Check for inconsistency between home_owner and home_market_value
SELECT *
FROM demographic
WHERE home_owner = 1
  AND home_market_value IS NULL;

-- Note: There are 6,545 rows for individuals marked as homeowners without a specified home market value.