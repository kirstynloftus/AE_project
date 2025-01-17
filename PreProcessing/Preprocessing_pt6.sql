SELECT * FROM ae_df WHERE NOT patient_patientonsetageunit = 801; --making sure query was successful
--since we have converted all ages into years, the unit column is no longer needed
ALTER TABLE ae_df
DROP COLUMN patient_patientonsetageunit;
