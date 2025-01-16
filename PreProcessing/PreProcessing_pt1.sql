SELECT * FROM dbo.ae_df

ALTER TABLE ae_df
DROP COLUMN primarysource_literaturereference, authoritynumb; -- columns definitely not necessary for our purposes

-- counting frequency of values in each column
DECLARE @sql NVARCHAR(MAX)

SET @sql = ''

SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS Column_Name, ' + COLUMN_NAME + ' AS Column_Value, COUNT(*) AS Frequency ' + CHAR(13) +
    'FROM ae_df ' + CHAR(13) +
    'GROUP BY ' + COLUMN_NAME + ' ' + CHAR(13) +
    'ORDER BY Frequency DESC;' + CHAR(13)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ae_df';

EXEC sp_executesql @sql;
