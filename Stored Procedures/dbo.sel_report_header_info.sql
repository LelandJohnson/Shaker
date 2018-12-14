SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve applicant name, date and position name for display in report
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_report_header_info] (
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint 
)
AS

SELECT     Applicant_Sessions.Start_Date, Applicant_Sessions.Completion_Date, Applicants.Last_Name, Applicants.First_Name, Applicants.Middle_Initial, 
                      Assessments.Full_Title, Assessments.Short_Title
FROM         Applicant_Sessions INNER JOIN
                      Applicants ON Applicant_Sessions.Applicant_ID = Applicants.Applicant_ID INNER JOIN
                      Assessments ON Applicant_Sessions.Assessment_ID = Assessments.Assessment_ID
WHERE
	Applicant_Sessions.Applicant_ID = @Applicant_ID and
	Applicant_Sessions.Assessment_ID = @Assessment_ID and
	Applicant_Sessions.Session_ID = @Session_ID
	
GO
