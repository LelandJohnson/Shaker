SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get req info for transact/req if passed in
--				in aor order, so first will be original one posted to us
-- History:		v1 to determine original package id for merrill edge messaging
--				and verify req in url exists
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_single_req_info]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@Req_ID VARCHAR(50),
	@Integration_System tinyint = 1 --default to system 1
	)
	
AS

SET NOCOUNT ON

SELECT Candidate_External_ID, Requisition_ID, Session_External_ID,
       Integration_Detail_A, Integration_Detail_B, Dynamic_Ext_URL, Active_Req
  from dbo.Applicant_Integration_Data IntData
  where Applicant_ID=@Applicant_ID and
	    Assessment_ID=@Assessment_ID and
	    Session_ID=@Session_ID AND
        IntData.Requisition_ID LIKE @Req_ID AND
	    Integration_System = @Integration_System
GO
