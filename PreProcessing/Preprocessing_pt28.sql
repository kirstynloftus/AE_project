--continuing to evaluate columns with NULLs
SELECT * FROM new_ae_data WHERE primarysourcecountry = 'NULL'; --making sure query worked

SELECT * FROM new_ae_data WHERE occurcountry = 'NULL';

--once again, as this is not even 15% of the rows in the dataset, I feel comfortable deleting them.

DELETE FROM new_ae_data WHERE occurcountry = 'NULL';

SELECT * FROM new_ae_data --checking that it's now 15,873 rows