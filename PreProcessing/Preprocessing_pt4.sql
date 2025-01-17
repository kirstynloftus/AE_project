SELECT TOP 20 * FROM ae_df;

SELECT * FROM ae_df WHERE patient_patientsex = 0 OR patient_patientsex IS NULL; --making sure query was successful

--checking if there are any values not = 1 or = 2 for serious, as I want that to be my response variable
SELECT DISTINCT serious FROM ae_df;
--thus, serious column is finished pre-processing... 26 more to go!

--checking if there are any abnormal ageunit values
SELECT DISTINCT patient_patientonsetageunit FROM ae_df;

--determing how many NULL values are in ageunit observations, which would make determining age in years difficult
SELECT * FROM ae_df WHERE patient_patientonsetageunit IS NULL;

--since this is significantly less than half the observations, I feel comfortable deleting these observations without losing too much info
DELETE FROM ae_df WHERE patient_patientonsetageunit IS NULL; 