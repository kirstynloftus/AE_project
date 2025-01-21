select * from new_ae_data; --confirming there is 18,399 rows

--next step: finishing up eliminating all duplicates (to the best of my ability, that is)

--finding identical rows:

DECLARE @sql NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX);

SELECT @columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', ') 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'new_ae_data'

SET @sql = 'SELECT ' + @columns + ', COUNT(*) AS DuplicateCount ' + CHAR(13) + 
           'FROM new_ae_data ' + CHAR(13) + 
           'GROUP BY ' + @columns + ' ' + CHAR(13) + 
           'HAVING COUNT(*) > 1 ' + CHAR(13) + 
           'ORDER BY DuplicateCount DESC;';

EXEC sp_executesql @sql;

--therefore, no obvious duplicates. one last check: the 13 rows with non-NULL values (i.e., the expanded_ae_data table)

--Finding unique values for duplicatenumb and how often they occur:
SELECT duplicatenumb, COUNT(*) AS OccurrenceCount
FROM expanded_ae_data
GROUP BY duplicatenumb
ORDER BY OccurrenceCount DESC;

--making sure it adds up to 80 (i.e. counted correctly)
SELECT SUM(OccurenceCount) AS TotalOccurences
FROM (
	SELECT duplicatenumb, COUNT(*) AS OccurenceCount
	FROM expanded_ae_data
	GROUP BY duplicatenumb
) AS SubQuery;

--Seeing if duplicatenumb values occur anywhere in any companynumb values in columns with NULL duplicate values (i.e., those not included in expanded_ae_data)
SELECT *
FROM ae_data
WHERE companynumb LIKE '%2014TEU009629%' 
   OR companynumb LIKE '%CA-PFIZER INC-202200388507%'
   OR companynumb LIKE '%000310272%'
   OR companynumb LIKE '%E2B_03428005%'
   OR companynumb LIKE '%2020SF01844%'
   OR companynumb LIKE '%000916050%'
   OR companynumb LIKE '%000926929%'
   OR companynumb LIKE '%000933935%'
   OR companynumb LIKE '%000960750%'
   OR companynumb LIKE '%1309422%'
   OR companynumb LIKE '%2008AP001944%'
   OR companynumb LIKE '%2014253654%'
   OR companynumb LIKE '%CA-Health Canada-E2B_00043427%'
   OR companynumb LIKE '%CAN-2014-0005175%'
   OR companynumb LIKE '%000627916%'
   OR companynumb LIKE '%CA-Pfizer-2014253654%'
   OR companynumb LIKE '%E2B_00043427%';

--this tells me that three rows, or part (possibly all) of one report are duplicates of another. 
--report: CA-PFIZER INC-2014253654 (expanded ae_data: CA-Pfizer-2014253654)

--After close examination, the duplicates do not provide any additional information, so they are not needed and can be deleted. doing that now:

DELETE FROM new_ae_data
WHERE duplicatenumb = 'CA-Pfizer-2014253654';

SELECT * FROM new_ae_data --checking that there's 18,396 rows now (deleted 3)