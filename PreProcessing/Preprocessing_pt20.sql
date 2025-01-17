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

--columns with many nulls: authoritynumb, reportduplicatecate

--i do not think authoritynumb is needed, but reportduplicate has 13 rows of interest that might help in ID'ing duplicates.
--As this data is stored as JSON-like info, I  will use pandas to further clean the data before returning to SQL. 