SELECT * FROM ae_data; --making sure there is 18,332 rows 

--making sure all duplicates were handled 

--DECLARE @sql NVARCHAR(MAX);
--DECLARE @columns NVARCHAR(MAX);

--SELECT @columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', ') 
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE TABLE_NAME = 'ae_data'
--  AND COLUMN_NAME != 'safetyreportid'


--SET @sql = 'SELECT ' + @columns + ', COUNT(*) AS DuplicateCount ' + CHAR(13) + 
  --         'FROM ae_data ' + CHAR(13) + 
    --       'GROUP BY ' + @columns + ' ' + CHAR(13) + 
      --     'HAVING COUNT(*) > 1 ' + CHAR(13) + 
        --   'ORDER BY DuplicateCount DESC;';

--EXEC sp_executesql @sql;

--next steps: tackle any columns with many NULLS (input data if possible, otherwise delete; use unique values dynamic query), then,
--if critical columns have just a few observations with NULL values, delete the rows containing null values, merge rows so each row
--has a unique safetyreportid (instead of multiple rows for the same report), add age groups, and build models!!