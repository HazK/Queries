 SELECT
 qryStats.last_execution_time AS [Time]
 ,qryText.TEXT AS [Query]
 ,DB_NAME(qryText.[dbid]) AS [Database]
 ,OBJECT_NAME(qryText.[objectid]) AS [TableName]
 FROM sys.dm_exec_query_stats AS qryStats
 CROSS APPLY sys.dm_exec_sql_text(qryStats.sql_handle) AS qryText
 WHERE qryText.TEXT LIKE '%Invoiced%'
 ORDER BY qryStats.last_execution_time DESC