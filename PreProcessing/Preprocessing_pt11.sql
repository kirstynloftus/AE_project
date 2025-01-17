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

--as there are many NULL values for patient_patientweight, and I cannot use other columns to determine these values, I will delete the column
--additionally, as i do not know how the FDA differentiates age groups (ex: "adult" vs "ederly"), I will delete that column and later replace it with my own
ALTER TABLE ae_data
DROP COLUMN patient_patientweight, patient_patientagegroup;

SELECT TOP 20 * FROM ae_data; --checking if query worked
 