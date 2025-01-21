--now that both tables have the same columns and they're the same data type, i can merge them.

SELECT * 
INTO new_ae_data
FROM ae_data
UNION ALL
SELECT * 
FROM expanded_ae_data;


--next steps: finishing up eliminating all duplicates (to the best of my ability, that is),
--determining what columns/rows should be deleted based off presence of NULLs and/or are just unncessary
--make sure data types are all appropriate,
--and grouping by safetyid so each row has a unique value for that column.
