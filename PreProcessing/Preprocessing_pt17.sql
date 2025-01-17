--as companynumb should be different for every adverse event (i.e. no two reports for different events should have the same companynumb value),
--any complete duplicates found by the below query can be assumed to be duplicates

DECLARE @sql NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX);

SELECT @columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', ') 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'ae_data'
  AND COLUMN_NAME != 'safetyreportid'


SET @sql = 'SELECT ' + @columns + ', COUNT(*) AS DuplicateCount ' + CHAR(13) + 
           'FROM ae_data ' + CHAR(13) + 
           'GROUP BY ' + @columns + ' ' + CHAR(13) + 
           'HAVING COUNT(*) > 1 ' + CHAR(13) + 
           'ORDER BY DuplicateCount DESC;';

EXEC sp_executesql @sql;


--This table has 18,551 rows, 408 of which have at least one duplicate, or 189 groups. 
--if we keep one observation of each, we keep 189 rows. 
--408-189 = 219 rows to remove, so when we de-duplicate the data, there should be 18,332 rows remaining
