SELECT TOP 20 * FROM ae_df;

SELECT * FROM ae_df WHERE patient_patientsex = 0 OR patient_patientsex IS NULL

--since there are only 233 observations (of 6000) where gender doesn't equal 1 or 2, I feel comfortable deleting them without losing too much info

ALTER TABLE ae_df
ALTER COLUMN patient_patientsex TINYINT; --converting from character to int

DELETE FROM ae_df WHERE patient_patientsex = 0 OR patient_patientsex IS NULL;