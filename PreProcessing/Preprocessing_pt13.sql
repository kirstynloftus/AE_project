--since I cannot determine what reactionoutcome values mean, even after researching, I will delete the column as it holds no meaning
ALTER TABLE ae_data
DROP COLUMN reactionoutcome;

SELECT TOP 20 * FROM ae_data; --making sure query worked