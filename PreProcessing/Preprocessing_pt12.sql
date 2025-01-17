SELECT TOP 20 * FROM ae_data;
--deleting more columns I don't need:
ALTER TABLE ae_data
DROP COLUMN reactionmeddraversionpt, primarysource_reportercountry, primarysource_qualification;

SELECT TOP 20 * FROM ae_data; --making sure query worked