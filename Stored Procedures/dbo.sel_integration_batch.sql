SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		jw
-- Description:	Retrieve applicants to include in batch xml post
--				will have integration flag set true
-- History:		v1
--				v2 include ext login id for logging
--				v2w workday variation, returns all users across all vjt's
--				    completed more than @Session_Age_Minutes minutes ago
-- =============================================
CREATE PROCEDURE [dbo].[sel_integration_batch]
 (
	@Session_Age_Minutes SMALLINT
 )
AS
    SELECT  Applicant_Sessions.Applicant_ID ,
            Applicant_Sessions.Assessment_ID ,
            Applicant_Sessions.Session_ID ,
            Applicants.Login_ID ,
			'Complete' AS [Mode] , 
			DATEDIFF(MINUTE, Completion_Date, GETDATE()) AS MinutesAgo,
			Completion_Date
    FROM    Applicant_Sessions
            INNER JOIN Applicants ON Applicant_Sessions.Applicant_ID = Applicants.Applicant_ID
    WHERE   ( Applicant_Sessions.Integration_Flag = 1 AND DATEDIFF(MINUTE, Completion_Date, GETDATE())  > @Session_Age_Minutes )
	ORDER BY Completion_Date ASC
    
GO
