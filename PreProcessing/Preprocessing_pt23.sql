--Merging the two tables together:

--since duplicatesource, duplicatenumb don't exist in ae_data, we need to add these columns before we can merge.
--luckily, since all values for these columns are NULL, this is fairly easy. we also need to delete the reportduplicate column.

ALTER TABLE ae_data
ADD duplicatesource nvarchar(max) NULL,
    duplicatenumb nvarchar(max) NULL;

ALTER TABLE ae_data
DROP COLUMN reportduplicate;