--next steps: determining what rows should be deleted based off presence of NULLs, making sure data types are all appropriate, 
--and grouping by safetyid so each row has a unique value for that column.

SELECT * FROM new_ae_data WHERE primarysourcecountry = 'NULL';
--since there's only 43 rows (of over 18,000 total) where this is true, I feel ok deleting these.

DELETE FROM new_ae_data WHERE primarysourcecountry = 'NULL';

SELECT * FROM new_ae_data --checking that it's now 18,353 rows