-- 1) Count the total number of rows in the address table
SELECT COUNT(*)
FROM address;

-- 2) Analyze null and unique counts for each column in the address table
WITH null_counts AS (
  SELECT
   'Null Counts' AS address_data,
   SUM(CASE WHEN address_id IS NULL THEN 1 ELSE 0 END) AS address_id,
   SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS latitude,
   SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS longitude,
   SUM(CASE WHEN street_address IS NULL THEN 1 ELSE 0 END) AS street_address,
   SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city,
   SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS state,
   SUM(CASE WHEN county IS NULL THEN 1 ELSE 0 END) AS county
  FROM address
),
unique_counts AS (
  SELECT
   'Unique Counts' AS address_data,
   COUNT(DISTINCT address_id) AS address_id,
   COUNT(DISTINCT latitude) AS latitude,
   COUNT(DISTINCT longitude) AS longitude,
   COUNT(DISTINCT street_address) AS street_address,
   COUNT(DISTINCT city) AS city,
   COUNT(DISTINCT state) AS state,
   COUNT(DISTINCT county) AS county
  FROM address
)
SELECT * FROM null_counts
UNION ALL
SELECT * FROM unique_counts;
