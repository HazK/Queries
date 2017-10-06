SELECT TOP 20 SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(qt.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1),
qs.last_execution_time,
qs.execution_count,
qs.total_elapsed_time,
(qs.total_elapsed_time / qs.execution_count)/1000000 AS Average_Elapsed_Time_S,
(qs.total_elapsed_time / qs.execution_count)/1000 AS Average_Elapsed_Time_MS,
qs.last_elapsed_time/1000 Last_Elapsed_Time_MS,
(qs.total_logical_reads / qs.execution_count) AS Average_Reads,
qs.last_logical_reads,
(qs.total_logical_writes / qs.execution_count) AS Average_Writes,
qs.last_logical_writes,
(qs.total_worker_time / qs.execution_count) AS Average_CPU,
qs.last_worker_time,
qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE qp.dbid = DB_ID('SodexoOMS')
ORDER BY Average_Elapsed_Time_MS DESC -- logical reads
-- ORDER BY qs.total_logical_writes DESC -- logical writes
-- ORDER BY qs.total_worker_time DESC -- CPU time