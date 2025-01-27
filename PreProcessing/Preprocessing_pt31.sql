SELECT * FROM new_ae_data; --making sure there is 4,115 rows
--First, renaming table for simplicity (i've now deleted old table)
EXEC sp_rename 'new_ae_data', 'ae_data';

