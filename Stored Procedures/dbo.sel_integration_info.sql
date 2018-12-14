SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get integration id's and url's for this applicant's session
--				most recent first
-- History:		v1 3/2015
--
-- =============================================
CREATE PROCEDURE [dbo].[sel_integration_info]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@Requisition_ID VARCHAR(50) = '%',
	@Integration_System tinyint = 1 --default to system 1
	)
	
AS

SET NOCOUNT ON

SELECT Candidate_External_ID, Requisition_ID, Session_External_ID,
       Integration_Detail_A, Integration_Detail_B, Dynamic_Ext_URL, Active_Req
  from dbo.Applicant_Integration_Data IntData
  where Applicant_ID=@Applicant_ID and
	    Assessment_ID=@Assessment_ID AND
	    Session_ID=@Session_ID AND
		Requisition_ID LIKE @Requisition_ID AND      
	    Integration_System = @Integration_System
  order by Integration_ID desc





GO
