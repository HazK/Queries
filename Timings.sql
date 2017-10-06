DECLARE @MaxCOunt int
DECLARE @CurrentCount int
DECLARE @StartTimeDateTime datetime

SET @StartTImeDateTime = '2016-05-17 21:49'

SET @MaxCount =(
SELECT COUNT(1) FROM cc_policy WITH (NOLOCK))

SET @CurrentCount =
(SELECT COUNT(1) FROM ccx_policymap WITH (NOLOCK))


SELECT
	DATEDIFF(mi,@StartTimeDateTime, GETDATE()) MinsSoFar,
	@Currentcount RecordsDoneSoFar,
	@MaxCount TotalRecords,
	@MaxCount / @CurrentCount ProportionDone,
	((@MaxCount / @CurrentCount) * DATEDIFF(mi,@StartTimeDateTime, GETDATE())) - DATEDIFF(mi,@StartTimeDateTime, GETDATE()) MinsLeft,
	(((@MaxCount / @CurrentCount) * DATEDIFF(mi,@StartTimeDateTime, GETDATE())) - DATEDIFF(mi,@StartTimeDateTime, GETDATE()))/ 60 HoursLeft,
	((((@MaxCount / @CurrentCount) * DATEDIFF(mi,@StartTimeDateTime, GETDATE())) - DATEDIFF(mi,@StartTimeDateTime, GETDATE()))/ 60 ) / 24 DaysLeft