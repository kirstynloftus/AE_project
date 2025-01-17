SELECT TOP 20 * FROM ae_df;

SELECT * FROM ae_df WHERE primarysourcecountry <> occurcountry; --Seeing if there are any such instances

--finding details about unique values:
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

--deleting more columns that don't aid in my research goals
ALTER TABLE ae_df
DROP COLUMN sender_sendertype, sender_senderorganization, receiver_receivertype, receiver_receiverorganization;