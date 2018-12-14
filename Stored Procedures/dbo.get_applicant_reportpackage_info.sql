SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get all reqs for this applicant's session
--				along with name and login id to use for auto-filename in report batch.
--				based on get_applicant_integration_reqs that just returns reqs.
-- History:		v1
--              v2 altered sql to allow for no integration data and still return applicant + session info

-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_reportpackage_info]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@Integration_System tinyint = 1 --default to system 1
	)
	
AS

SET NOCOUNT ON

SELECT     Applicants.Login_ID, Applicants.Last_Name, Applicants.First_Name, Applicant_Sessions.Status_Code, IntData.Candidate_External_ID, IntData.Requisition_ID, IntData.Session_External_ID, 
                      IntData.Integration_Detail_A, IntData.Integration_Detail_B, IntData.Dynamic_Ext_URL, IntData.Active_Req
FROM         Applicants LEFT OUTER JOIN
                      Applicant_Sessions ON Applicants.Applicant_ID = Applicant_Sessions.Applicant_ID AND Applicant_Sessions.Session_ID = @Session_ID AND 
                      Applicant_Sessions.Assessment_ID = @Assessment_ID LEFT OUTER JOIN
                      Applicant_Integration_Data AS IntData ON IntData.Applicant_ID = Applicants.Applicant_ID
WHERE     (Applicants.Applicant_ID = @Applicant_ID) AND (((IntData.Assessment_ID = @Assessment_ID) AND (IntData.Session_ID = @Session_ID) AND 
                      (IntData.Integration_System = @Integration_System)) or (IntData.Applicant_ID is null))
ORDER BY IntData.Integration_ID
  

for xml auto, elements




GO
