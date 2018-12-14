SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
Report data generator: Completion totals and percentages, incompletes, progress, and times
pass in just date filter params, since it is reporting on completions it will look at all statuses

return how many touches, completions, how much time spent
jw
			
history:	v1 - does not divide different content versions.

*/
CREATE PROCEDURE [dbo].[report_completion]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime
	)
	
AS
	SET NOCOUNT ON



--incompletes/statuses for timeframe (not by month)
SELECT  case Status_Code
		 when 2 then 'Complete'
		 when 1 then 'Incomplete'
		 when 0 then 'Not Started'
		 else 'Not Started'
		end as [Status],
		COUNT(applicant_id) as [StatusCount]
    FROM Applicant_Sessions as [asn]

			 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  
		
                      
GROUP BY Status_Code
order by Status_Code desc


-- over under 30 minutes. (elapsed_time and question_time are in seconds, so use 1800 seconds as divider 
SELECT  case 
		 when [asn].Elapsed_Time=0 then 'Zero'
		 when [asn].Elapsed_Time>0 and [asn].Elapsed_Time<1800 then 'Less than 30'
		 when [asn].Elapsed_Time >= 1800 then 'Greater than 30'
		end  as [Incompletes_TimeSpent],
		COUNT(Applicant_ID) as [TimeSpentCount]
		
    FROM Applicant_Sessions as [asn]

			 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code<2
		  and not (Elapsed_Time is null) --don't count if no elapsed time recorded
		
group by case 
		  when [asn].Elapsed_Time=0 then 'Zero'
		  when [asn].Elapsed_Time>0 and [asn].Elapsed_Time<1800 then 'Less than 30'
		  when [asn].Elapsed_Time >= 1800 then 'Greater than 30'
		 end                   
order by [Incompletes_TimeSpent] desc --reverse alphabetically happens to be zero, less than 30, greater than 30 order


--time to complete, with outlier treatment a couple of ways
--first determine mean, standard dev
declare @MeanCompletionTime as int
declare @MeanQuestionTime as int
declare @StdevCompletionTime as int
declare @StdevQuestionTime as int
declare @TwoStdevAbove_C as int
declare @ThreeStdevAbove_C as int
declare @TwoStdevAbove_Q as int
declare @ThreeStdevAbove_Q as int

declare @MaxElapsedTime as int
declare @MaxQuestionTime as int


select  @MeanCompletionTime = AVG(Elapsed_Time),
		@MeanQuestionTime = AVG(Question_Time),
		@StdevCompletionTime = STDEVP(Elapsed_Time),
		@StdevQuestionTime = STDEVP(Question_Time),
		@MaxElapsedTime = MAX(Elapsed_Time),
		@MaxQuestionTime = MAX(Question_Time)
		
    FROM Applicant_Sessions as [asn]
		 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2

--2 and 3 stdev's about mean for completion time and for question time
set @TwoStdevAbove_C = @MeanCompletionTime + (2*@StdevCompletionTime)
set @ThreeStdevAbove_C = @MeanCompletionTime + (3*@StdevCompletionTime)

set @TwoStdevAbove_Q = @MeanQuestionTime + (2*@StdevQuestionTime)
set @ThreeStdevAbove_Q = @MeanQuestionTime + (3*@StdevQuestionTime)

--select @MeanCompletionTime as [MeanCompletionTime], @MeanQuestionTime as [MeanQuestionTime],
--@StdevCompletionTime as [StdevCompletionTime], @StdevQuestionTime as [StdevQuestionTime],
--@TwoStdevAbove_C as [TwoStdevAbove_C], @ThreeStdevAbove_C as [ThreeStdevAbove_C],
--@TwoStdevAbove_Q as [TwoStdevAbove_Q], @ThreeStdevAbove_Q as [ThreeStdevAbove_Q]


select 'Average elapsed time (less than mean+two stdev)' as Time_Version, AVG(elapsed_time)/60 as Time_Values, MAX(Elapsed_Time)/60 as Highest
    FROM Applicant_Sessions as [asn]
		 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2
		  and Elapsed_Time < @TwoStdevAbove_C
		  
union

select 'Average elapsed time (less than mean+three stdev)', AVG(elapsed_time)/60 as ElapsedTime_without3stdev, MAX(Elapsed_Time)/60
    FROM Applicant_Sessions as [asn]
		 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2
		  and Elapsed_Time < @ThreeStdevAbove_C
		  
union

select 'Average elapsed time (all)', @MeanCompletionTime/60 as ElapsedTime_All, @MaxElapsedTime/60


union



----same but for question times
select 'Average question time (less than mean+two stdev)' as Time_Version, AVG(Question_time)/60 as Time_Values, MAX(Question_time)/60 as Maximums
    FROM Applicant_Sessions as [asn]
		 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2
		  and Question_Time < @TwoStdevAbove_Q
		  
union

select 'Average question time (less than mean+three stdev)' Time_Version, AVG(Question_time)/60 as QuestionTime_without3stdev, MAX(Question_time)/60 
    FROM Applicant_Sessions as [asn]
		 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2
		  and Question_Time < @ThreeStdevAbove_Q
		  
union

select 'Average question time (all)' Time_Version, @MeanQuestionTime/60 as QuestionTime_All, @MaxQuestionTime/60



order by Time_Version asc




---median elapsed_times (all, <mean+2stdev, <mean+3stdev


select 'Median elapsed time (less than mean+two stdev' MedianVersion, avg(Elapsed_Time)/60 as Median_Time_Values from
(select Elapsed_Time, 
rnasc = row_number() over(order by Elapsed_Time),
rndesc = row_number() over(order by Elapsed_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
		  and Elapsed_Time < @TwoStdevAbove_C
) b
where rnasc between rndesc - 1 and rndesc + 1

union

select 'Median elapsed time (less than mean+three stdev)' MedianVersion, avg(Elapsed_Time)/60 median_3s from
(select Elapsed_Time, 
rnasc = row_number() over(order by Elapsed_Time),
rndesc = row_number() over(order by Elapsed_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
		  and Elapsed_Time < @ThreeStdevAbove_C
) b
where rnasc between rndesc - 1 and rndesc + 1

union

select 'Median elapsed time (all)' MedianVersion, avg(Elapsed_Time)/60 MedianMinutes from
(select Elapsed_Time, 
rnasc = row_number() over(order by Elapsed_Time),
rndesc = row_number() over(order by Elapsed_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
 
) b
where rnasc between rndesc - 1 and rndesc + 1


---and finally median question times
---median elapsed_times (all, <mean+2stdev, <mean+3stdev
union


select 'Median question time (less than mean+two stdev' MedianVersion, avg(Question_Time)/60 median_2s from
(select Question_Time, 
rnasc = row_number() over(order by Question_Time),
rndesc = row_number() over(order by Question_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
		  and Question_Time < @TwoStdevAbove_Q
) b
where rnasc between rndesc - 1 and rndesc + 1

union

select 'Median question time (less than mean+three stdev)' MedianVersion, avg(Question_Time)/60 median_3s from
(select Question_Time, 
rnasc = row_number() over(order by Question_Time),
rndesc = row_number() over(order by Question_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
		  and Question_Time < @ThreeStdevAbove_Q
) b
where rnasc between rndesc - 1 and rndesc + 1

union

select 'Median question time (all)' MedianVersion, avg(Question_Time)/60 MedianMinutes from
(select Question_Time, 
rnasc = row_number() over(order by Question_Time),
rndesc = row_number() over(order by Question_Time desc)
 from Applicant_Sessions as [asn]
 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
		  and Status_Code=2 
 
) b
where rnasc between rndesc - 1 and rndesc + 1



order by MedianVersion asc


-----------------------
--sessions created by month
SELECT  YEAR(start_date) as StartYear,
        MONTH(start_date) as StartMonth,
        COUNT(applicant_id) as [SessionCount]
    FROM Applicant_Sessions as [asn]

			 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 
                      
GROUP BY YEAR(start_date), MONTH(start_date)
ORDER BY YEAR(start_date), MONTH(start_date)


--completions by month
SELECT  YEAR(start_date) as StartYear,
        MONTH(start_date) as StartMonth,
        COUNT(applicant_id) as [CompleteCount]
    FROM Applicant_Sessions as [asn]

			 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) and 
		  
		  asn.Status_Code=2
                      
GROUP BY YEAR(start_date), MONTH(start_date)
ORDER BY YEAR(start_date), MONTH(start_date)

GO
