SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	update language code for user's session.
--				asp/aspx already checked it was allowed.
-- History:		v1 - rollout
-- =============================================
CREATE PROCEDURE [dbo].[upd_session_language]
	(@Applicant_ID int,
     @Assessment_ID tinyint,
     @Session_ID tinyint,
     @Language_Code varchar(24)
    )
AS

--leave nocount off to verify write

		UPDATE dbo.Applicant_Sessions
		 set Language_Code = @Language_Code
		WHERE
			Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID
GO
