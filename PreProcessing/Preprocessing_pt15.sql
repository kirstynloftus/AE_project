--finding unique values of each column

DECLARE @sql NVARCHAR(MAX)

SET @sql = ''

SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS Column_Name, ' + COLUMN_NAME + ' AS Column_Value, COUNT(*) AS Frequency ' + CHAR(13) +
    'FROM ae_data ' + CHAR(13) +
    'GROUP BY ' + COLUMN_NAME + ' ' + CHAR(13) +
    'ORDER BY Frequency DESC;' + CHAR(13)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ae_data';

EXEC sp_executesql @sql;

--columns with many NULLs: reportduplicate, authoritynumb.

--checking for complete duplicates for every column BUT safetyreportid (that was unique for each entry before I merged tables and created several rows 
--of the same id)

--as companynumb should be different for every adverse event (i.e. no two reports for different events should have the same companynumb value),
--any complete duplicates found by the below query can be assumed to be duplicates *note: excluding NULLs since we can't determine company number*

DECLARE @sql2 NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX);

SELECT @columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', ') 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'ae_data'
  AND COLUMN_NAME != 'safetyreportid'


SET @sql2 = 'SELECT ' + @columns + ', COUNT(*) AS DuplicateCount ' + CHAR(13) + 
           'FROM ae_data ' + CHAR(13) + 
		   'WHERE companynumb != ''NULL'' ' + CHAR(13) +
           'GROUP BY ' + @columns + ' ' + CHAR(13) + 
           'HAVING COUNT(*) > 1 ' + CHAR(13) + 
           'ORDER BY DuplicateCount DESC;';

EXEC sp_executesql @sql2;

--next steps: delete these duplicates, tackle any columns with many NULLS (input data if possible, otherwise delete), 
--if critical columns have just a few observations with NULL values, delete the rows containing null values, 
--add age groups, and build models!!

