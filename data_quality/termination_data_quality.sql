-- 1) Count the total number of rows in the termination table
SELECT COUNT(*)
FROM termination;

-- 2) Analyze null and unique counts for each column in the termination table
WITH null_counts AS (
  SELECT
   'Null Counts' AS termination_data,
   SUM(CASE WHEN individual_id IS NULL THEN 1 ELSE 0 END) AS individual_id,
   SUM(CASE WHEN acct_suspd_date IS NULL THEN 1 ELSE 0 END) AS acct_suspd_date
  FROM termination
),
unique_counts AS (
  SELECT
   'Unique Counts' AS termination_data,
   COUNT(DISTINCT individual_id) AS individual_id,
   COUNT(DISTINCT acct_suspd_date) AS acct_suspd_date
  FROM termination
)
SELECT * FROM null_counts
UNION ALL
SELECT * FROM unique_counts;

-- 3) Check for outliers in account suspension dates (e.g., very old or very new dates)
SELECT 
  MIN(acct_suspd_date) AS earliest_date,
  MAX(acct_suspd_date) AS latest_date
FROM termination;