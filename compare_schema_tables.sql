
SELECT 
	FT.name , 
	ST.name  , 
	FT.system_type_name  , 
	ST.system_type_name ,
	FT.max_length  , 
	ST.max_length ,
	FT.precision  , 
	ST.precision ,
	FT.scale  , 
	ST.scale ,
	FT.is_nullable  , 
	ST.is_nullable , 
	FT.is_identity_column  , 
	ST.is_identity_column 
FROM sys.dm_exec_describe_first_result_set (N'SELECT * FROM [Agenda].[dbo].[teste]', NULL, 0) FT
	LEFT OUTER JOIN  sys.dm_exec_describe_first_result_set (N'SELECT * FROM [Agenda2].[dbo].[teste]', NULL, 0) ST
ON FT.Name =ST.Name

-------------------------------------------------------------------------------------------------------------
WITH CTE AS (
    SELECT TABLE_NAME, COLUMN_NAME FROM Agenda.INFORMATION_SCHEMA.COLUMNS
    UNION
    SELECT TABLE_NAME, COLUMN_NAME FROM Agenda2.INFORMATION_SCHEMA.COLUMNS
)
SELECT CTE.TABLE_NAME, CTE.COLUMN_NAME, CASE
    WHEN DB1.COLUMN_NAME IS NULL THEN 'DB2 Only'
    WHEN DB2.COLUMN_NAME IS NULL THEN 'DB1 Only'
    ELSE 'BOTH DB'
END AS [Present In]
FROM CTE
LEFT JOIN Agenda.INFORMATION_SCHEMA.COLUMNS AS DB1 ON CTE.TABLE_NAME = DB1.TABLE_NAME AND CTE.COLUMN_NAME = DB1.COLUMN_NAME
LEFT JOIN Agenda2.INFORMATION_SCHEMA.COLUMNS AS DB2 ON CTE.TABLE_NAME = DB2.TABLE_NAME AND CTE.COLUMN_NAME = DB2.COLUMN_NAME
WHERE 
	DB1.COLUMN_NAME IS NULL OR DB2.COLUMN_NAME IS NULL
	AND DB1.TABLE_NAME <> 'sysdiagrams' OR DB2.TABLE_NAME <> 'sysdiagrams'
