SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve dimension scores in xml format
--				for integration results xml or other quick view without definitions
-- History:		v1
--				v1.1 fixed bug that was returning all scoring versions' scores. now limited
--				     to applicant's scoring version for session in applicant_sessions
--
-- =============================================
CREATE PROCEDURE [dbo].[get_scores_integration_xml] (
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint 
)
AS

SELECT     dims.Dimension_Name as dimname, dimer.Dimension_Score as score, dims.Flag_Criteria, 
                      dimer.Dimension_ID as dimid
FROM         Applicant_Sessions INNER JOIN
                      Dimension_Scores dimer ON Applicant_Sessions.Applicant_ID = dimer.Applicant_ID AND 
                      Applicant_Sessions.Assessment_ID = dimer.Assessment_ID AND Applicant_Sessions.Session_ID = dimer.Session_ID INNER JOIN
                      Dimensions dims ON dimer.Assessment_ID = dims.Assessment_ID AND dimer.Dimension_ID = dims.Dimension_ID AND 
                      dimer.Scoring_Version = dims.Scoring_Version
WHERE     (Applicant_Sessions.Applicant_ID = @Applicant_ID) AND (Applicant_Sessions.Assessment_ID = @Assessment_ID) AND 
                      (Applicant_Sessions.Session_ID = @Session_ID) and dimer.Scoring_Version = Applicant_Sessions.Scoring_Version
ORDER BY dims.Report_Order
	
FOR XML AUTO, ELEMENTS
GO
