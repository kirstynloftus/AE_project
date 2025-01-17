--joining tables and creating new table for this data
DECLARE @sql AS NVARCHAR(MAX);
DECLARE @cols AS NVARCHAR(MAX);

SELECT @cols = STRING_AGG(column_name, ', ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'ae_df' AND column_name <> 'safetyreportid';

SET @sql = 'SELECT e.safetyreportid, e.reactionmeddraversionpt, e.reactionmeddrapt, e.reactionoutcome, '
		   + @cols + ' INTO merged_ae_data FROM expanded_ae_data e LEFT JOIN ae_df a ON e.safetyreportid = a.safetyreportid;';

EXEC sp_executesql @sql;