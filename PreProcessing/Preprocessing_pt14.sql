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

--columns of concern (many NULLS): seriousnesscongenitalanomali, seriousnesslifethreatening, seriousnessdeath, seriousnessother, seriousnessdisabling, 
--seriousnesshospitalization. unless serious = 2 and one of these other columns = 1 (i.e., "yes"), I will simply remove these
--columns as not much can be done to fill in the missing data.
SELECT * FROM ae_data WHERE serious = '2' AND 
	(seriousnesscongenitalanomali = '1' OR
	seriousnesslifethreatening = '1' OR 
	seriousnessdeath = '1' OR
	seriousnessother = '1' OR
	seriousnessdisabling = '1' OR
	seriousnesshospitalization = '1');

--since there are no such columns, I will delete seriousnesscongenitalanomali, seriousnesslifethreatening, seriousnessdeath, seriousnessother, 
--seriousnessdisabling, and seriousnesshospitalization.
	
ALTER TABLE ae_data
DROP COLUMN seriousnesscongenitalanomali, seriousnesslifethreatening, seriousnessdeath, seriousnessother, seriousnessdisabling, seriousnesshospitalization;

SELECT TOP 20 * FROM ae_data; --Checking query worked