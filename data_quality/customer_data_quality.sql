-- 1) Count the total number of rows in the customer table
SELECT COUNT(*)
FROM customer;

-- 2) Analyze null and unique counts for each column in the customer table
WITH null_counts AS (
  SELECT
   'Null Counts' AS customer_data,
   SUM(CASE WHEN individual_id IS NULL THEN 1 ELSE 0 END) AS individual_id,
   SUM(CASE WHEN address_id IS NULL THEN 1 ELSE 0 END) AS address_id,
   SUM(CASE WHEN curr_ann_prem IS NULL THEN 1 ELSE 0 END) AS curr_ann_prem,
   SUM(CASE WHEN days_tenure IS NULL THEN 1 ELSE 0 END) AS days_tenure,
   SUM(CASE WHEN cust_orig_date IS NULL THEN 1 ELSE 0 END) AS cust_orig_date,
   SUM(CASE WHEN age_in_years IS NULL THEN 1 ELSE 0 END) AS age_in_years,
   SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth,
   SUM(CASE WHEN social_sec_number IS NULL THEN 1 ELSE 0 END) AS social_sec_number
  FROM customer
),
unique_counts AS (
  SELECT
   'Unique Counts' AS customer_data,
   COUNT(DISTINCT individual_id) AS individual_id,
   COUNT(DISTINCT address_id) AS address_id,
   COUNT(DISTINCT curr_ann_prem) AS curr_ann_prem,
   COUNT(DISTINCT days_tenure) AS days_tenure,
   COUNT(DISTINCT cust_orig_date) AS cust_orig_date,
   COUNT(DISTINCT age_in_years) AS age_in_years,
   COUNT(DISTINCT date_of_birth) AS date_of_birth,
   COUNT(DISTINCT social_sec_number) AS social_sec_number
  FROM customer
)
SELECT * FROM null_counts
UNION ALL
SELECT * FROM unique_counts;

-- 3) Check for invalid values in numeric columns
SELECT *
FROM customer
WHERE age_in_years < 0 OR age_in_years > 120  -- Age values should be within a realistic range.
   OR curr_ann_prem <= 0                      -- Premiums should be positive as negative values indicate data errors or special cases like refunds or credits.
   OR days_tenure <= 0                        -- Tenure should be positive, indicating active duration of insurance coverage.

-- 4) There are 71 rows which have negative annual premiums. Check if customers with negative premiums have account termination records.
-- This query explores whether the negative premiums are associated with account terminations,
-- which could suggest refunds or adjustments upon policy cancellation.
SELECT 
  c.*, 
  t.acct_suspd_date
FROM customer c
LEFT JOIN termination t ON c.individual_id = t.individual_id
WHERE curr_ann_prem <= 0;

-- Explanation:
-- The negative premium values are excluded from the analysis because their meaning is unclear.
-- These negative values could represent refunds, billing errors, or adjustments, but without clear context, 
-- they introduce uncertainty. Including them could distort the analysis of standard customer payments, average premiums,
-- or total revenue. To ensure accurate results, only positive premium values will be used in the analysis.

-- 5) Analyze the range of customer origin dates and dates of birth
SELECT 
  MIN(cust_orig_date) AS min_orig,
  MAX(cust_orig_date) AS max_orig,
  MIN(date_of_birth) AS min_birth,
  MAX(date_of_birth) AS max_birth
FROM customer;
