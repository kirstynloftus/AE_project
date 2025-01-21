SELECT * from expanded_ae_data; --should be 80 rows

--Combining tables
--First, deleting rows from ae_data where reportduplicate != 'NULL'
--deleting 13 rows should result in 18,319 rows
DELETE FROM ae_data WHERE reportduplicate != 'NULL';

SELECT * from ae_data; --should be 18,319 rows
