
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
