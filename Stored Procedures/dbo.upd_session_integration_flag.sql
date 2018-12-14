SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	update which integration id currently in use or set integration condition
-- History:		v1 - rollout
-- =============================================
CREATE PROCEDURE [dbo].[upd_session_integration_flag]
	(@Applicant_ID int,
     @Assessment_ID tinyint,
     @Session_ID tinyint,
     @Integration_Flag tinyint,
     @Requisition_ID varchar(50) = null
    )
AS

--leave nocount off to verify write

declare @Integration_ID tinyint

if @Requisition_ID is null
	begin
		--just update to flag passed in
		UPDATE dbo.Applicant_Sessions
		 set Integration_Flag = @Integration_Flag
		WHERE
			Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID
	
	
	end
else
	begin
		--get flag value from applicant_integration_data table
		select @Integration_ID=Integration_ID from Applicant_Integration_Data
								where Applicant_ID = @Applicant_ID and Assessment_ID=@Assessment_ID
								and	Session_ID=@Session_ID and Requisition_ID like @Requisition_ID
								
		UPDATE dbo.Applicant_Sessions
		 set Integration_Flag = @Integration_ID
		WHERE
			Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID
		
	
	end
	
GO
