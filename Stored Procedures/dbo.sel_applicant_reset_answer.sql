SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Verify correct applicant reset answer
--				Pass in answer and return login_id if correct
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant_reset_answer]
    (@Applicant_ID as integer,
	 @UserAnswer as varchar(50)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Login_ID from Applicants
	 where Applicant_ID = @Applicant_ID 
	   and Password_ResetA like @UserAnswer	

END
GO
