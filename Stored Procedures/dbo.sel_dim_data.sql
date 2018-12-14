SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve dimension scores for classic asp reports
-- History:		v1 defaulted to just 1 scoring version
--
--				v2 12/29/2011 retrieving dims associated with applicant's scoring version (can be different dim names/defs/vars)
-- =============================================
CREATE PROCEDURE [dbo].[sel_dim_data] (
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint 
)
AS

SELECT     Dimensions.Dimension_Name, Dimensions.Dimension_Definition, Dimension_Scores.Dimension_Score, Dimensions.Flag_Criteria, 
                      Dimensions.Dimension_Flagged_Definition, Applicant_Sessions.Start_Date, Applicant_Sessions.Completion_Date, Dimensions.SymbolTableLookup
FROM         Applicant_Sessions INNER JOIN
                      Dimension_Scores ON Applicant_Sessions.Applicant_ID = Dimension_Scores.Applicant_ID AND 
                      Applicant_Sessions.Assessment_ID = Dimension_Scores.Assessment_ID AND Applicant_Sessions.Session_ID = Dimension_Scores.Session_ID INNER JOIN
                      Dimensions ON Dimension_Scores.Assessment_ID = Dimensions.Assessment_ID AND Dimension_Scores.Dimension_ID = Dimensions.Dimension_ID AND 
                      Dimension_Scores.Scoring_Version = Dimensions.Scoring_Version
WHERE     (Applicant_Sessions.Applicant_ID = @Applicant_ID) AND (Applicant_Sessions.Assessment_ID = @Assessment_ID) AND 
                      (Applicant_Sessions.Session_ID = @Session_ID) and (Applicant_Sessions.Scoring_Version = Dimensions.Scoring_Version)
ORDER BY Dimensions.Report_Order
	
GO
