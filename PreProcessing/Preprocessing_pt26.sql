--next steps: determining what columns should be deleted based off presence of NULLs and/or are just unncessary.

--finding unique values of each column

DECLARE @sql NVARCHAR(MAX)

SET @sql = ''

SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS Column_Name, ' + COLUMN_NAME + ' AS Column_Value, COUNT(*) AS Frequency ' + CHAR(13) +
    'FROM new_ae_data ' + CHAR(13) +
    'GROUP BY ' + COLUMN_NAME + ' ' + CHAR(13) +
    'ORDER BY Frequency DESC;' + CHAR(13)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'new_ae_data';

EXEC sp_executesql @sql;

--columns with no NULLs: safetyreportid, reactionmeddrapt, safetyreportversion, reporttype, serious, companynumb, patient_patient_sex, patient_patientonsetage
--columns with many NULLs (keeping in mind 18,396 rows in dataset): authoritynumb, duplicatesource, duplicatenumb
--columns with a few (but not concerning amount) of NULLs: reportduplicate_duplicatenumb, reportduplicate_duplicatesource, duplicate, occurcountry, 
--and primarysourcecountry

--cross-referencing with FDA info, authoritynumb is not needed. and as duplicatesource, duplicatenumb were just to ID duplicates (which we've finished),
--those aren't needed either. Furthermore, for the same reason, reportduplicate_duplicatenumb, reportduplicate_duplicatesource, duplicate aren't needed. 
--Additionally, safetyreportversion, reporttype, are also not needed. Lastly, as reactionmeddrapt did not provide any helpful information, 
--we can delete that column, too. 

--the only columns we need at this point are: safetyreportid, primarysourcecountry, occurcountry, serious, companynumb, patient_patientsex, 
--and patient_patientonsetage

--deleting reactionmeddrapt, safetyreportversion, reporttype, authoritynumb, duplicatesource, duplicatenumb, reportduplicate_duplicatenumb, 
--reportduplicate_duplicatesource, and duplicate:

ALTER TABLE new_ae_data
DROP COLUMN reactionmeddrapt, safetyreportversion, reporttype, authoritynumb, duplicatesource, duplicatenumb, reportduplicate_duplicatenumb, 
reportduplicate_duplicatesource, duplicate;
