SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
=============================================
Report data generator: Feedback Answer Distribution
pass in filter params (date range)

return how many of each answer for each fb measure (numeric only)

jw

assumption: common content version, especially when reordering fb choices 1-4 vs 4-1

history:	v1

=============================================
*/
CREATE PROCEDURE [dbo].[report_feedback]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From DATETIME = null,
	@Start_Date_To DATETIME = null,
	@Completion_Date_From DATETIME = null,
	@Completion_Date_To DATETIME = null
	)
	
AS
	SET NOCOUNT ON

SELECT        Measures.Measure_Name, [amn].Value, COUNT(*) AS AnswerCount
FROM            Applicant_Measures_Num [amn]
			    INNER JOIN Measures
					 ON [amn].Measure_ID = Measures.Measure_ID
				INNER JOIN dbo.Applicant_Sessions [asn]
				     ON [amn].Applicant_ID = [asn].Applicant_ID
					 AND [amn].Assessment_ID = [asn].Assessment_ID
					 AND [amn].Session_ID = [asn].Session_ID
					 --AND [asn].Content_Version = Measures.Content_Version --future implementation
					 AND [asn].Assessment_ID = @Assessment_ID
					 AND [amn].Assessment_ID = @Assessment_ID
					                       
WHERE        ([amn].Assessment_ID = @Assessment_ID) AND (Measures.Section_Abbr LIKE 'fb') AND (NOT ([amn].Value IS NULL)) AND (NOT ([amn].Value = 0))
			AND 
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) 

GROUP BY Measures.Measure_Name, [amn].Value
ORDER BY Measures.Measure_Name, [amn].Value

GO
