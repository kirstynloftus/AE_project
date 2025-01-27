--Next step: grouping by safetyreportid so each row has a unique value for that column.
--First, renaming table for simplicity
EXEC sp_rename 'new_ae_data', 'ae_data';

--finding how many values there are for safetyreportid:
SELECT DISTINCT safetyreportid
FROM ae_data;

--thus, our condensed table should have 4,115 rows. First, checking whether some safetyreportids have differing info
--(will affect how I condense):
SELECT safetyreportid,
       COUNT(DISTINCT primarysourcecountry) AS DistinctPrimarySourceCountry,
       COUNT(DISTINCT occurcountry) AS DistinctOccurCountry,
	   COUNT(DISTINCT serious) AS DistinctSeriousCount,
	   COUNT(DISTINCT companynumb) AS DistinctCompanyNumb,
	   COUNT(DISTINCT patient_patientsex) AS DistinctSex,
	   COUNT(DISTINCT patient_patientonsetage) AS DistinctAge
FROM ae_data
GROUP BY safetyreportid
HAVING COUNT(DISTINCT primarysourcecountry) > 1 OR COUNT(DISTINCT occurcountry) > 1 OR 
	   COUNT(DISTINCT serious) > 1 OR COUNT(DISTINCT companynumb) > 1 OR 
	   COUNT(DISTINCT patient_patientsex) > 1 OR
	   COUNT(DISTINCT patient_patientonsetage) > 1;

--since there are no such rows, rows with identical safetyreportid values are also identical in every other column.
--Condensing this table will be easy, then!

SELECT safetyreportid,
       MAX(primarysourcecountry) AS primarysourcecountry,
       MAX(occurcountry) AS occurcountry,
       MAX(serious) AS serious,
       MAX(companynumb) AS companynumb,
       MAX(patient_patientsex) AS patient_patientsex,
       MAX(patient_patientonsetage) AS patient_patientonsetage
INTO new_ae_data
FROM ae_data
GROUP BY safetyreportid;



