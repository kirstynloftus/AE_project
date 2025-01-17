SELECT TOP 20 * FROM ae_df
--step one: deleting columns i know aren't needed for my purposes (used FDA document for variable explanation)
ALTER TABLE ae_df
DROP COLUMN transmissiondateformat, transmissiondate, 
receivedateformat, receivedate, receiptdateformat, receiptdate, fulfillexpeditecriteria, patient_summary_narrativeincludeclinical,
primarysource_literaturereference; 