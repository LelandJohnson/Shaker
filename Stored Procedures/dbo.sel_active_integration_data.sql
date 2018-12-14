SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve applicant name, date and position name for display in report
-- History:		v1
--              v1.1 added Session_External_ID
--				v2 active integrations must include non-expired date stamp
-- =============================================
CREATE PROCEDURE [dbo].[sel_active_integration_data]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Session_ID TINYINT 
    )
AS
    SELECT  Candidate_External_ID ,
            Requisition_ID ,
            Dynamic_Ext_URL ,
            Integration_Detail_A ,
            Integration_Detail_B ,
            Active_Req ,
            aid.Session_External_ID,
            aid.Expiration_Date
    FROM    Applicant_Sessions
            INNER JOIN Applicant_Integration_Data aid ON Applicant_Sessions.Applicant_ID = aid.Applicant_ID
                                                         AND Applicant_Sessions.Assessment_ID = aid.Assessment_ID
                                                         AND Applicant_Sessions.Session_ID = aid.Session_ID
                                                       --  AND ISNULL(Applicant_Sessions.Integration_Flag, 1) = aid.Integration_ID
    WHERE   Applicant_Sessions.Applicant_ID = @Applicant_ID
            AND Applicant_Sessions.Assessment_ID = @Assessment_ID
            AND Applicant_Sessions.Session_ID = @Session_ID
			AND aid.Expiration_Date > GETDATE();
	
GO
