--wrapping dynamic SQL query in a transaction to ensure data integrity

BEGIN TRANSACTION;

DECLARE @columns NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

SELECT @columns = STRING_AGG(QUOTENAME(column_name), ', ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ae_data' AND COLUMN_NAME != 'safetyreportid';

SET @sql = '
WITH CTE AS (
	SELECT
		safetyreportid,
		' + @columns + ',
		ROW_NUMBER() OVER (
			PARTITION BY ' + @columns + '
			ORDER BY safetyreportid
		) AS rn
	FROM ae_data
)
SELECT
	safetyreportid,
	' + @columns + '
INTO #TempData
FROM CTE
WHERE rn = 1;

DELETE FROM ae_data;

INSERT INTO ae_data (safetyreportid, ' + @columns + ')
SELECT safetyreportid, ' + @columns + ' FROM #TempData;

DROP TABLE #TempData;
';

EXEC sp_executesql @sql;

COMMIT;