SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get all reqs for this applicant's session
--				in aor order, so first will be original one posted to us
-- History:		v1
--
--				v2 added @Integration_System to support multiple integration systems, defaults to 1
--				   if not supplied.
--				v2.1 order by oldest to newest
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_integration_reqs]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@Integration_System tinyint = 1 --default to system 1
	)
	
AS

SET NOCOUNT ON

SELECT Candidate_External_ID, Requisition_ID, Session_External_ID,
       Integration_Detail_A, Integration_Detail_B, Dynamic_Ext_URL, Active_Req
  from dbo.Applicant_Integration_Data IntData
  where Applicant_ID=@Applicant_ID and
	    Assessment_ID=@Assessment_ID and
	    Session_ID=@Session_ID and
	    Integration_System = @Integration_System
  order by Integration_ID ASC
  

for xml auto, elements








GO
