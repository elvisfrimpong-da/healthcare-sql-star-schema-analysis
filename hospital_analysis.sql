CREATE DATABASE hospital;

USE hospital;

SELECT *
FROM bed_fact;
SELECT *
FROM bed_type;
SELECT  *
FROM business;

## Identify Hospitals with ICU or SICU Beds
SELECT
    b.business_name AS hospital_name,
    MAX(CASE WHEN f.bed_id = 4 THEN 'Yes' ELSE 'No' END) AS Has_ICU,
    MAX(CASE WHEN f.bed_id = 15 THEN 'Yes' ELSE 'No' END) AS Has_SICU
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY b.business_name;

# 4a1 Summary Report 1: Top 10 Hospitals by Total ICU or SICU License Beds
SELECT
    b.business_name AS hospital_name,
    SUM(f.license_beds) AS total_license_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_license_beds DESC
LIMIT 10;

# Summary Report 2
# 10 Hospitals by Total ICU or SICU Census Beds
SELECT
    b.business_name AS hospital_name,
    SUM(f.census_beds) AS total_census_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_census_beds DESC
LIMIT 10;

# Summary Report 3
#Top 10 Hospitals by Total ICU or SICU Staffed Beds
SELECT
    b.business_name AS hospital_name,
    SUM(f.staffed_beds) AS total_staffed_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_staffed_beds DESC
LIMIT 10;

# 5b Top 10 Hospitals by License Beds (ICU and SICU)
SELECT
    b.business_name AS hospital_name,
    SUM(f.license_beds) AS total_license_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING
    SUM(CASE WHEN f.bed_id = 4 THEN f.license_beds ELSE 0 END) > 0
    AND
    SUM(CASE WHEN f.bed_id = 15 THEN f.license_beds ELSE 0 END) > 0
ORDER BY total_license_beds DESC
LIMIT 10;

# Top 10 Hospitals by Census Beds (ICU and SICU)
SELECT
    b.business_name AS hospital_name,
    SUM(f.census_beds) AS total_census_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING
    SUM(CASE WHEN f.bed_id = 4 THEN f.census_beds ELSE 0 END) > 0
    AND
    SUM(CASE WHEN f.bed_id = 15 THEN f.census_beds ELSE 0 END) > 0
ORDER BY total_census_beds DESC
LIMIT 10;

# Top 10 Hospitals by Staffed Beds (ICU and SICU)
SELECT
    b.business_name AS hospital_name,
    SUM(f.staffed_beds) AS total_staffed_beds
FROM bed_fact f
JOIN business b
    ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING
    SUM(CASE WHEN f.bed_id = 4 THEN f.staffed_beds ELSE 0 END) > 0
    AND
    SUM(CASE WHEN f.bed_id = 15 THEN f.staffed_beds ELSE 0 END) > 0
ORDER BY total_staffed_beds DESC
LIMIT 10;

