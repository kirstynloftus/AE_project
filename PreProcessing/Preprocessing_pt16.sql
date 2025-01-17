--as there is no real way to know if columns with companynumb = NULL could be potential duplicates, I will first delete any rows where such a value occurs
--first, id'ing how many such rows there are
SELECT * FROM ae_data WHERE companynumb = 'NULL';
--1,376 rows have companynumb = NULL
--thus, deleting these rows will result in a table with 19,927 - 1,376 = 18,551 rows remaining after deletion
DELETE FROM ae_data WHERE companynumb = 'NULL';
SELECT * FROM ae_data --making sure query worked correctly 