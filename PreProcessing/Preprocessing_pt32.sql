--last checks: no NULLs and safetyreportid, companynumb are unique for each row. 
--to make it easier, i'll check these using dynamic sql:
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

--each safetyreportid occurs only once, and no NULLs seem to be present. 
--however, companynumb values do repeat a few times, so i need to investigate this further.
--companynumb	AU-MYLANLABS-2014S1016431	
--companynumb	CH-ASTRAZENECA-2014SE65535	
--companynumb	DE-MYLANLABS-2014S1013185	
--companynumb	GB-ACTAVIS-2014-20777	
--companynumb	GB-MYLANLABS-2014S1012591	
--companynumb	GB-SA-2014SA126000	
--companynumb	SE-MYLANLABS-2014S1010648	
--companynumb	IT-MYLANLABS-2014S1005466	
--companynumb	GB-WATSON-2014-09951	
--companynumb	GB-ACTAVIS-2014-05047	
--companynumb	GB-MYLANLABS-2014S1012475	