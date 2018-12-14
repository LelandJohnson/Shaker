SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE    PROCEDURE [dbo].[sel_applicant_pwd_q] (@login_id varchar(50), @Password_Question varchar(150) OUTPUT)
AS 
IF EXISTS (SELECT Login_ID FROM Applicants Where Login_ID like @login_id)
		BEGIN
			SELECT @Password_Question = Password_ResetQ FROM Applicants where Login_ID = @Login_ID
			return
		END
	SELECT @Password_Question = 'no_q'
	return



GO
