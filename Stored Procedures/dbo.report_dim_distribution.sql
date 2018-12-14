SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
Report data generator: Dimension/Competency Distribution
pass in filter params (date + status code)

return how many of each score, grouped by scoring version
jw

assumption: relies on a content update (new content version) having a new scoring
			algorithm, so only grouping by scoring version is necessary.
			(scoring version would cover both renorms and content changes with
			new corresponding scoring)

history:	v1

*/
CREATE PROCEDURE [dbo].[report_dim_distribution]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint	
	)
	
AS
	SET NOCOUNT ON


SELECT  isnull(Dimension_Scores.Scoring_Version,1) as Scoring_Version, Dimension_Scores.Dimension_ID, 
        Dimension_Scores.Dimension_Score, Dimensions.Dimension_Name, SPSS_Variable, COUNT(Dimension_Score) as ScoreCount
FROM         Dimension_Scores INNER JOIN
                      Applicant_Sessions [asn] ON
                      Dimension_Scores.Applicant_ID = [asn].Applicant_ID AND 
                      Dimension_Scores.Assessment_ID = [asn].Assessment_ID AND
                      Dimension_Scores.Session_ID = [asn].Session_ID AND
                      Dimension_Scores.Assessment_ID = @Assessment_ID and
                      Dimension_Scores.Scoring_Version = [asn].Scoring_Version

			INNER JOIN Dimensions on
			 Dimension_Scores.Scoring_Version = Dimensions.Scoring_Version and
			 Dimension_Scores.Assessment_ID = Dimensions.Assessment_ID and
			 Dimension_Scores.Dimension_ID = Dimensions.Dimension_ID
			 

WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) and 
		  
		  ( 
		  ((@Status_Code1 is null) or ([asn].Status_Code = @Status_Code1)) and
		  ((@Status_Code2 is null) or ([asn].Status_Code = @Status_Code2))
		  )		  
                      
group by Dimension_Scores.Dimension_ID, Dimension_Scores.Scoring_Version, Dimension_Score, Dimension_Name, SPSS_Variable
order by Scoring_Version, Dimension_ID, Dimension_Score


GO
