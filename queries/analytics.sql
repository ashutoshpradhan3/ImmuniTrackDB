-- ANALYTICS.SQL :: IMMUNITRACKDB --

-- ===============================
-- ANALYTICS & INSIGHTS QUERIES
-- ===============================

-- 1. City with the highest number of vaccinations
SELECT L.CITY, COUNT(*) AS total_vaccinations
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
GROUP BY L.CITY
ORDER BY total_vaccinations DESC
LIMIT 1;

-- 2. Most common age group among vaccinated individuals
SELECT AGE, COUNT(*) AS count
FROM VACCINATION_RECORD
GROUP BY AGE
ORDER BY count DESC
LIMIT 1;

-- 3. Worker(s) who vaccinated the most people
SELECT HW.WORKER_ID, HW.POST, H.NAME AS HOSPITAL_NAME, COUNT(*) AS total
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
JOIN HOSPITAL H ON HW.HOSPITAL_ID = H.HOSPITAL_ID
GROUP BY HW.WORKER_ID, HW.POST, H.NAME
ORDER BY total DESC
LIMIT 1;

-- 4. Country with the highest number of vaccine exports
SELECT E.RECEIVER AS COUNTRY, SUM(E.QUANTITY) AS total_exported
FROM EXPORT E
GROUP BY E.RECEIVER
ORDER BY total_exported DESC
LIMIT 1;

-- 5. Total vaccine exports per country
SELECT E.RECEIVER AS COUNTRY, SUM(E.QUANTITY) AS total_exported
FROM EXPORT E
GROUP BY E.RECEIVER
ORDER BY total_exported DESC;

-- 6. Hospital with the highest number of workers
SELECT H.NAME, COUNT(*) AS worker_count
FROM HEALTH_WORKERS HW
JOIN HOSPITAL H ON HW.HOSPITAL_ID = H.HOSPITAL_ID
GROUP BY H.NAME
ORDER BY worker_count DESC
LIMIT 1;

-- 7. Most senior health worker (oldest DOB)
SELECT C.FNAME, C.LNAME, C.DOB, L.CITY
FROM HEALTH_WORKERS HW
JOIN CITIZENS C ON HW.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
ORDER BY C.DOB ASC
LIMIT 1;

-- 8. Vaccination center with the most number of visits
SELECT VC.CENTER_ID, VC.AREA, COUNT(*) AS total_visits
FROM VACCINATION_RECORD VR
JOIN VACCINATION_CENTER VC ON VR.CENTER_ID = VC.CENTER_ID
GROUP BY VC.CENTER_ID, VC.AREA
ORDER BY total_visits DESC
LIMIT 1;

-- 9. Number of vaccinations per vaccine type
SELECT V.NAME, COUNT(*) AS total_given
FROM VACCINATION_RECORD VR
JOIN VACCINE V ON VR.VACCINE_ID = V.VACCINE_ID
GROUP BY V.NAME
ORDER BY total_given DESC;

-- 10. Monthly vaccination trend
SELECT MONTH(DATETIME) AS month, COUNT(*) AS count
FROM VACCINATION_RECORD
GROUP BY month
ORDER BY month;

-- 11. Number of unique citizens vaccinated
SELECT COUNT(DISTINCT AADHAR_NUMBER) AS unique_citizens
FROM VACCINATION_RECORD;

-- 12. Vaccines exported by each supplier
SELECT S.NAME AS SUPPLIER_NAME, COUNT(DISTINCT E.VACCINE_ID) AS total_exported_types
FROM EXPORT E
JOIN VACCINE V ON E.VACCINE_ID = V.VACCINE_ID
JOIN SUPPLIERS S ON V.SUPPLIER_ID = S.ID
GROUP BY S.NAME
ORDER BY total_exported_types DESC;

-- 13. Export quantity per vaccine
SELECT V.NAME, SUM(E.QUANTITY) AS total_quantity
FROM EXPORT E
JOIN VACCINE V ON E.VACCINE_ID = V.VACCINE_ID
GROUP BY V.NAME
ORDER BY total_quantity DESC;

-- 14. Suppliers operating in more than one pincode
SELECT PINCODE, COUNT(*) AS supplier_count
FROM SUPPLIERS
GROUP BY PINCODE
HAVING COUNT(*) > 1;

-- 15. List of all citizens vaccinated at a specific center
SELECT C.FNAME, C.LNAME, VR.DATETIME
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
WHERE VR.CENTER_ID = 'C1301';

-- 16. Total vaccines given per hospital
SELECT H.NAME, COUNT(*) AS total_given
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
JOIN HOSPITAL H ON HW.HOSPITAL_ID = H.HOSPITAL_ID
GROUP BY H.NAME
ORDER BY total_given DESC;

-- 17. Citizens who have received more than one vaccination
SELECT AADHAR_NUMBER, COUNT(*) AS doses
FROM VACCINATION_RECORD
GROUP BY AADHAR_NUMBER
HAVING doses > 1;

-- 18. Number of different vaccine types used at each center
SELECT CENTER_ID, COUNT(DISTINCT VACCINE_ID) AS vaccine_types
FROM VACCINATION_RECORD
GROUP BY CENTER_ID;

-- 19. Workers who vaccinated citizens in more than one center
SELECT WORKER_ID, COUNT(DISTINCT CENTER_ID) AS centers
FROM VACCINATION_RECORD
GROUP BY WORKER_ID
HAVING centers > 1;

-- 20. Vaccination records in the last 30 days
SELECT *
FROM VACCINATION_RECORD
WHERE DATETIME >= CURDATE() - INTERVAL 30 DAY;

-- 21. List of vaccines manufactured in a specific year
SELECT * FROM VACCINE
WHERE YEAR(DATEOFMANU) = 2020;

-- 22. Vaccines that have never been exported
SELECT V.NAME
FROM VACCINE V
LEFT JOIN EXPORT E ON V.VACCINE_ID = E.VACCINE_ID
WHERE E.VACCINE_ID IS NULL;

-- 23. Top 3 busiest vaccination centers
SELECT CENTER_ID, COUNT(*) AS total
FROM VACCINATION_RECORD
GROUP BY CENTER_ID
ORDER BY total DESC
LIMIT 3;

-- 24. Number of suppliers per city
SELECT L.CITY, COUNT(S.ID) AS supplier_count
FROM SUPPLIERS S
JOIN LOCATION L ON S.PINCODE = L.PINCODE
GROUP BY L.CITY;

-- 25. Find average age of vaccinated citizens
SELECT AVG(AGE) AS average_age
FROM VACCINATION_RECORD;

-- 26. List of vaccines approved before 2000
SELECT * FROM VACCINE
WHERE DATEOFMANU < '2000-01-01';

-- 27. Centers that received more than one type of vaccine
SELECT CENTER_ID
FROM INVENTORY
GROUP BY CENTER_ID
HAVING COUNT(DISTINCT VACCINE_ID) > 1;

-- 28. Top 5 hospitals by vaccine administration
SELECT H.NAME, COUNT(*) AS administered
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
JOIN HOSPITAL H ON HW.HOSPITAL_ID = H.HOSPITAL_ID
GROUP BY H.NAME
ORDER BY administered DESC
LIMIT 5;

-- 29. Export destinations and number of unique vaccines received
SELECT RECEIVER, COUNT(DISTINCT VACCINE_ID) AS unique_vaccines
FROM EXPORT
GROUP BY RECEIVER
ORDER BY unique_vaccines DESC;

-- 30. Most recently manufactured vaccine
SELECT * FROM VACCINE
ORDER BY DATEOFMANU DESC
LIMIT 1;

-- 31. Vaccines used in more than 2 hospitals
SELECT VACCINE_ID
FROM INVENTORY
GROUP BY VACCINE_ID
HAVING COUNT(DISTINCT HOSPITAL_ID) > 2;

-- 32. Cities with more than 2 suppliers
SELECT L.CITY, COUNT(S.ID) AS supplier_count
FROM SUPPLIERS S
JOIN LOCATION L ON S.PINCODE = L.PINCODE
GROUP BY L.CITY
HAVING COUNT(S.ID) > 2;

-- 33. Hospitals with no health workers
SELECT H.NAME FROM HOSPITAL H
LEFT JOIN HEALTH_WORKERS HW ON H.HOSPITAL_ID = HW.HOSPITAL_ID
WHERE HW.HOSPITAL_ID IS NULL;

-- 34. Suppliers who have not supplied any vaccine
SELECT S.NAME FROM SUPPLIERS S
LEFT JOIN VACCINE V ON S.ID = V.SUPPLIER_ID
WHERE V.SUPPLIER_ID IS NULL;

-- 35. Vaccines used in the same center more than once
SELECT VACCINE_ID, CENTER_ID, COUNT(*)
FROM VACCINATION_RECORD
GROUP BY VACCINE_ID, CENTER_ID
HAVING COUNT(*) > 1;

-- 36. Top 5 oldest citizens who got vaccinated
SELECT C.FNAME, C.LNAME, C.DOB, VR.DATETIME
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
ORDER BY C.DOB ASC
LIMIT 5;

-- 37. Distinct hospitals a worker has worked in (via records)
SELECT VR.WORKER_ID, COUNT(DISTINCT HW.HOSPITAL_ID) AS hospitals
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
GROUP BY VR.WORKER_ID;

-- 38. Workers and number of citizens they vaccinated over 40
SELECT HW.WORKER_ID, COUNT(*) AS total
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
WHERE AGE > 40
GROUP BY HW.WORKER_ID;

-- 39. Total quantity of each vaccine in inventory
SELECT VACCINE_ID, SUM(QUANTITY) AS total_quantity
FROM INVENTORY
GROUP BY VACCINE_ID;

-- 40. Number of doses per citizen
SELECT AADHAR_NUMBER, COUNT(*) AS total_doses
FROM VACCINATION_RECORD
GROUP BY AADHAR_NUMBER;

-- 41. Health workers who are also citizens from Delhi
SELECT HW.WORKER_ID, C.FNAME, C.LNAME
FROM HEALTH_WORKERS HW
JOIN CITIZENS C ON HW.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
WHERE L.CITY = 'Delhi';

-- 42. Vaccines used in at least 3 different centers
SELECT VACCINE_ID
FROM VACCINATION_RECORD
GROUP BY VACCINE_ID
HAVING COUNT(DISTINCT CENTER_ID) >= 3;

-- 43. Workers who worked in more than one hospital
SELECT WORKER_ID, COUNT(DISTINCT HOSPITAL_ID) AS total_hospitals
FROM HEALTH_WORKERS
GROUP BY WORKER_ID
HAVING total_hospitals > 1;

-- 44. Vaccines never used in any inventory
SELECT V.VACCINE_ID, V.NAME
FROM VACCINE V
LEFT JOIN INVENTORY I ON V.VACCINE_ID = I.VACCINE_ID
WHERE I.VACCINE_ID IS NULL;

-- 45. Citizens from the same state as vaccine manufacture country
SELECT DISTINCT C.FNAME, C.LNAME, C.PINCODE, V.COUNTRY
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN VACCINE V ON VR.VACCINE_ID = V.VACCINE_ID
JOIN LOCATION L ON C.PINCODE = L.PINCODE
WHERE L.STATE = V.COUNTRY;

-- 46. Count of citizens vaccinated per gender
SELECT C.GENDER, COUNT(*) AS total
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
GROUP BY C.GENDER;

-- 47. Oldest vaccine used
SELECT V.NAME, V.DATEOFMANU
FROM VACCINE V
JOIN VACCINATION_RECORD VR ON V.VACCINE_ID = VR.VACCINE_ID
ORDER BY V.DATEOFMANU ASC
LIMIT 1;

-- 48. Average number of vaccinations per worker
SELECT AVG(worker_total) AS avg_per_worker
FROM (
  SELECT WORKER_ID, COUNT(*) AS worker_total
  FROM VACCINATION_RECORD
  GROUP BY WORKER_ID
) AS sub;

-- 49. Export quantity by month
SELECT MONTH(E.DATEOFMANU) AS month, SUM(E.QUANTITY) AS total
FROM EXPORT E
JOIN VACCINE V ON E.VACCINE_ID = V.VACCINE_ID
GROUP BY MONTH(E.DATEOFMANU);

-- 50. Cities with both suppliers and vaccination centers
SELECT DISTINCT L.CITY
FROM LOCATION L
JOIN SUPPLIERS S ON L.PINCODE = S.PINCODE
JOIN VACCINATION_CENTER VC ON L.PINCODE = VC.PINCODE;

-- 51. Hospitals that have administered all types of vaccines
SELECT H.NAME
FROM HOSPITAL H
JOIN HEALTH_WORKERS HW ON H.HOSPITAL_ID = HW.HOSPITAL_ID
JOIN VACCINATION_RECORD VR ON HW.WORKER_ID = VR.WORKER_ID
GROUP BY H.NAME
HAVING COUNT(DISTINCT VR.VACCINE_ID) = (SELECT COUNT(*) FROM VACCINE);

-- 52. Number of vaccines used per supplier
SELECT S.NAME, COUNT(DISTINCT VR.VACCINE_ID) AS vaccine_count
FROM SUPPLIERS S
JOIN VACCINE V ON S.ID = V.SUPPLIER_ID
JOIN VACCINATION_RECORD VR ON V.VACCINE_ID = VR.VACCINE_ID
GROUP BY S.NAME;

-- 53. Count of vaccines manufactured per country
SELECT COUNTRY, COUNT(*) AS count
FROM VACCINE
GROUP BY COUNTRY
ORDER BY count DESC;

-- 54. Age distribution of vaccinated citizens
SELECT
  CASE
    WHEN AGE < 18 THEN 'Below 18'
    WHEN AGE BETWEEN 18 AND 30 THEN '18-30'
    WHEN AGE BETWEEN 31 AND 45 THEN '31-45'
    WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS total
FROM VACCINATION_RECORD
GROUP BY age_group;

-- 55. List of hospitals that have received vaccines but haven’t administered them
SELECT DISTINCT H.NAME
FROM INVENTORY I
JOIN HOSPITAL H ON I.HOSPITAL_ID = H.HOSPITAL_ID
LEFT JOIN HEALTH_WORKERS HW ON HW.HOSPITAL_ID = H.HOSPITAL_ID
LEFT JOIN VACCINATION_RECORD VR ON HW.WORKER_ID = VR.WORKER_ID
WHERE VR.REFERENCE_ID IS NULL;

-- 56. Most recent vaccination date per citizen
SELECT AADHAR_NUMBER, MAX(DATETIME) AS last_vaccinated
FROM VACCINATION_RECORD
GROUP BY AADHAR_NUMBER;

-- 57. Average quantity of vaccine per inventory entry
SELECT AVG(QUANTITY) AS avg_quantity
FROM INVENTORY;

-- 58. Find centers that operate under multiple hospitals
SELECT CENTER_ID, COUNT(DISTINCT HOSPITAL_ID) AS hospitals
FROM INVENTORY
GROUP BY CENTER_ID
HAVING hospitals > 1;

-- 59. Workers that have vaccinated citizens at different centers on the same day
SELECT WORKER_ID, DATE(DATETIME) AS date_used
FROM VACCINATION_RECORD
GROUP BY WORKER_ID, DATE(DATETIME)
HAVING COUNT(DISTINCT CENTER_ID) > 1;

-- 60. Total vaccines administered grouped by weekday
SELECT DAYNAME(DATETIME) AS day_of_week, COUNT(*) AS total
FROM VACCINATION_RECORD
GROUP BY day_of_week;

-- 61. Citizens who got vaccinated on their birthday
SELECT C.FNAME, C.LNAME, C.DOB, VR.DATETIME
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
WHERE DAY(C.DOB) = DAY(VR.DATETIME)
  AND MONTH(C.DOB) = MONTH(VR.DATETIME);

-- 62. Monthly inventory supply trend
SELECT MONTH(LAST_ARRIVED) AS month, SUM(QUANTITY) AS total
FROM INVENTORY
GROUP BY month
ORDER BY month;

-- 63. Number of vaccinations per country of vaccine origin
SELECT V.COUNTRY, COUNT(*) AS total_administered
FROM VACCINATION_RECORD VR
JOIN VACCINE V ON VR.VACCINE_ID = V.VACCINE_ID
GROUP BY V.COUNTRY;

-- 64. Citizens per city who received more than one dose
SELECT L.CITY, COUNT(DISTINCT VR.AADHAR_NUMBER) AS multi_dose_citizens
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
GROUP BY L.CITY
HAVING multi_dose_citizens > 0;

-- 65. Workers with more than average vaccinations
SELECT WORKER_ID, COUNT(*) AS total
FROM VACCINATION_RECORD
GROUP BY WORKER_ID
HAVING total > (
  SELECT AVG(worker_count)
  FROM (
    SELECT COUNT(*) AS worker_count
    FROM VACCINATION_RECORD
    GROUP BY WORKER_ID
  ) AS sub
);

-- 66. Vaccine with the highest export-to-use ratio
SELECT V.NAME,
       SUM(E.QUANTITY) / COUNT(VR.VACCINE_ID) AS export_use_ratio
FROM VACCINE V
JOIN EXPORT E ON V.VACCINE_ID = E.VACCINE_ID
JOIN VACCINATION_RECORD VR ON V.VACCINE_ID = VR.VACCINE_ID
GROUP BY V.NAME
ORDER BY export_use_ratio DESC
LIMIT 1;

-- 67. Percentage of citizens vaccinated per city
SELECT L.CITY,
       COUNT(DISTINCT C.AADHAR_NUMBER) / (
         SELECT COUNT(*) FROM CITIZENS C2 WHERE C2.PINCODE = C.PINCODE
       ) * 100 AS percent_vaccinated
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
GROUP BY L.CITY, C.PINCODE;

-- 68. Number of different age groups per vaccine
SELECT VACCINE_ID,
       COUNT(DISTINCT
         CASE
           WHEN AGE < 18 THEN 'Below 18'
           WHEN AGE BETWEEN 18 AND 30 THEN '18-30'
           WHEN AGE BETWEEN 31 AND 45 THEN '31-45'
           WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
           ELSE '60+'
         END) AS age_brackets
FROM VACCINATION_RECORD
GROUP BY VACCINE_ID;

-- 69. Most popular vaccine per month
SELECT month, VACCINE_ID, MAX(total) AS max_used
FROM (
  SELECT MONTH(DATETIME) AS month, VACCINE_ID, COUNT(*) AS total
  FROM VACCINATION_RECORD
  GROUP BY month, VACCINE_ID
) AS monthly_vax
GROUP BY month;

-- 70. Create view: top 5 vaccinated cities
CREATE OR REPLACE VIEW Top5Cities AS
SELECT L.CITY, COUNT(*) AS total
FROM VACCINATION_RECORD VR
JOIN CITIZENS C ON VR.AADHAR_NUMBER = C.AADHAR_NUMBER
JOIN LOCATION L ON C.PINCODE = L.PINCODE
GROUP BY L.CITY
ORDER BY total DESC
LIMIT 5;

-- 71. Create view: active workers with 10+ vaccinations
CREATE OR REPLACE VIEW ActiveWorkers AS
SELECT WORKER_ID, COUNT(*) AS total
FROM VACCINATION_RECORD
GROUP BY WORKER_ID
HAVING total >= 10;

-- 72. Find total vaccines used by active workers
SELECT A.WORKER_ID, A.total
FROM ActiveWorkers A;

-- 73. List vaccines not used by any active worker
SELECT V.NAME
FROM VACCINE V
LEFT JOIN VACCINATION_RECORD VR ON V.VACCINE_ID = VR.VACCINE_ID
LEFT JOIN ActiveWorkers AW ON VR.WORKER_ID = AW.WORKER_ID
WHERE AW.WORKER_ID IS NULL;

-- 74. Most common vaccine per hospital
SELECT H.NAME, V.NAME, COUNT(*) AS total
FROM VACCINATION_RECORD VR
JOIN HEALTH_WORKERS HW ON VR.WORKER_ID = HW.WORKER_ID
JOIN HOSPITAL H ON HW.HOSPITAL_ID = H.HOSPITAL_ID
JOIN VACCINE V ON VR.VACCINE_ID = V.VACCINE_ID
GROUP BY H.NAME, V.NAME
ORDER BY total DESC;

-- 75. Identify under-utilized inventory (less than 100)
SELECT * FROM INVENTORY
WHERE QUANTITY < 100;

-- 76. Most exported vaccine by quantity
SELECT V.NAME, SUM(E.QUANTITY) AS total_exported
FROM EXPORT E
JOIN VACCINE V ON E.VACCINE_ID = V.VACCINE_ID
GROUP BY V.NAME
ORDER BY total_exported DESC
LIMIT 1;

-- 77. Number of citizens vaccinated in each year
SELECT YEAR(DATETIME) AS year, COUNT(DISTINCT AADHAR_NUMBER) AS total
FROM VACCINATION_RECORD
GROUP BY year;

-- 78. List of vaccines manufactured per supplier country
SELECT COUNTRY, COUNT(*) AS vaccine_count
FROM VACCINE
GROUP BY COUNTRY
ORDER BY vaccine_count DESC;

-- 79. Number of suppliers per state
SELECT L.STATE, COUNT(DISTINCT S.ID) AS supplier_count
FROM SUPPLIERS S
JOIN LOCATION L ON S.PINCODE = L.PINCODE
GROUP BY L.STATE;

-- 80. Distinct cities reached via export
SELECT DISTINCT RECEIVER FROM EXPORT;

-- ===============================
-- CLEANUP & DELETE OPERATIONS
-- ===============================

-- Delete vaccination records older than 5 years
DELETE FROM VACCINATION_RECORD
WHERE DATETIME < CURDATE() - INTERVAL 5 YEAR;

-- Delete all citizens from a specific pincode
DELETE FROM CITIZENS WHERE PINCODE = 410206;

-- Remove hospitals with zero workers
DELETE FROM HOSPITAL
WHERE HOSPITAL_ID NOT IN (SELECT DISTINCT HOSPITAL_ID FROM HEALTH_WORKERS);

-- Clear all exports for a discontinued vaccine
DELETE FROM EXPORT
WHERE VACCINE_ID = 981364;

-- Drop all helper views
DROP VIEW IF EXISTS Top5Cities;
DROP VIEW IF EXISTS ActiveWorkers;

-- Drop all tables (be cautious!)
DROP TABLE IF EXISTS VACCINATION_RECORD, HEALTH_WORKERS, INVENTORY, EXPORT, VACCINE,
SUPPLIES, VACCINATION_CENTER, HOSPITAL, SUPPLIERS, CITIZENS, LOCATION;

-- Drop database if needed
DROP DATABASE IF EXISTS ImmuniTrackDB;
