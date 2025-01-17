--Making sure query worked
SELECT * FROM ae_df WHERE patient_patientonsetageunit IS NULL;

--finding dimensions of dataframe (code from https://stackoverflow.com/questions/67129261/fastest-way-to-get-the-dimensions-of-a-table)
SELECT COUNT(*) as Dims
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ae_df'
UNION ALL
SELECT COUNT(*) FROM ae_df;

--converting all ages to years
ALTER TABLE ae_df
ALTER COLUMN patient_patientonsetage FLOAT;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ae_df' AND COLUMN_NAME = 'patient_patientonsetage'; --making sure conversion was successful

--making sure no decimal ages
SELECT *
FROM ae_df
WHERE patient_patientonsetage - FLOOR(patient_patientonsetage) > 0;

UPDATE ae_df
SET 
 patient_patientonsetage = CASE
	WHEN patient_patientonsetageunit = 800 THEN patient_patientonsetage * 10 --since unit = 800 corresponds to decades old
	WHEN patient_patientonsetageunit = 802 THEN FLOOR(patient_patientonsetage / 12) --Since unit = 802 corresponds to months old
	WHEN patient_patientonsetageunit = 803 THEN FLOOR(patient_patientonsetage / 52) --since unit = 803 corresponds to weeks old
	WHEN patient_patientonsetageunit = 804 THEN FLOOR(patient_patientonsetage / 365.25) --Since unit = 804 corresponds to days old, and 365.25 is the average number of days in a year (includes leap years)
	ELSE patient_patientonsetage
 END,
 patient_patientonsetageunit = CASE
	WHEN patient_patientonsetageunit IN (800, 802, 803, 804) THEN 801
	ELSE patient_patientonsetageunit
 END
WHERE patient_patientonsetageunit IN (800, 802, 803, 804);