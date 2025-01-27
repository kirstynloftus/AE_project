SELECT * FROM new_ae_data WHERE occurcountry = 'NULL'; --making sure query worked

--seeing if any other columns contain NULLs, excluding serious and sex as I handled those already:
SELECT * FROM new_ae_data WHERE safetyreportid IS NULL;

SELECT * FROM new_ae_data WHERE companynumb = 'NULL';

SELECT * FROM new_ae_data WHERE patient_patientsex = 'NULL';

SELECT * FROM new_ae_data WHERE patient_patientonsetage IS NULL;

--Thus, I have handled all NULL values.

--next step: making sure data types are all appropriate: safetyreportid is INT, country vars are chars, serious is INT, 
--companynumb is char, sex is INT, and age is INT
ALTER TABLE new_ae_data
ALTER COLUMN serious INT;

ALTER TABLE new_ae_data
ALTER COLUMN patient_patientsex INT;