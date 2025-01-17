--since I've parsed the data, I can now delete the patient_reaction column as all the information is present in new columns
ALTER TABLE ae_df
DROP COLUMN patient_reaction;

SELECT TOP 20* FROM ae_df; --confirming query was successful