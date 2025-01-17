SELECT TOP 20 * FROM ae_df; --making sure query was successful

--checking for duplicates
--from before, we know the following columns have no two+ rows with the same value: safetyreportid, reportduplicate_duplicatenumb, so these two wouldn't be 
--helpful in IDing potential duplicates
--finding rows with exact matches in every other column

DECLARE @sql NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX);

SELECT @columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', ') 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'ae_df'
AND COLUMN_NAME NOT IN ('safetyreportid', 'reportduplicate_duplicatenumb');

SET @sql = 'SELECT ' + @columns + ', COUNT(*) AS DuplicateCount ' + CHAR(13) + 
           'FROM ae_df ' + CHAR(13) + 
           'GROUP BY ' + @columns + ' ' + CHAR(13) + 
           'HAVING COUNT(*) > 1 ' + CHAR(13) + 
           'ORDER BY DuplicateCount DESC;';

EXEC sp_executesql @sql;

--there are 4 observations that are potential duplicates (one duplicate each for two observations)
--as patient_reaction is a JSON-like structure, I want to move this to pandas where it's easier to analyze the observations in that column
--after doing that, I will return to SQL

--first, deleting patient_drug column as everyone in this dataset took the same medicine (though perhaps different brands of it) and thus it is not useful for my analysis
ALTER TABLE ae_df
DROP COLUMN patient_drug;

SELECT TOP 20* FROM ae_df; --confirming query was successful
