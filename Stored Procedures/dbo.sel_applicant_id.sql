SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE        PROCEDURE [dbo].[sel_applicant_id] (@login_id varchar(50),@Password varchar(50), @Position_ID TINYINT,  @Applicant_ID int OUTPUT, @msg varchar(10) OUTPUT)
AS 
IF EXISTS (SELECT Login_ID FROM Applicants Where Login_ID like @login_id and [Password] like @Password)
		BEGIN
			SELECT @Applicant_ID = Applicant_ID from Applicants Where Login_ID like @login_id
			-- does this user have a session record for this position/test
			IF EXISTS (SELECT * from dbo.Applicant_Sessions Where Applicant_ID = @Applicant_ID AND Assessment_ID = @Position_ID)
				
				SELECT @msg = 'match', @Applicant_ID = @Applicant_ID

			ELSE
				
				SELECT @msg = 'notest', @Applicant_ID = @Applicant_ID


			IF NOT EXISTS (SELECT * FROM Applicant_Sessions WHERE [Applicant_ID] = @Applicant_ID  AND Assessment_ID = @Position_ID)
				INSERT  INTO Applicant_Sessions (
                     Applicant_ID,
                     Assessment_ID,
                     Session_ID,
                     Status_Code
                    )
            VALUES  (
                      @Applicant_ID,
                      @Position_ID,
                      1,
                      '0' )
			return
		END
	SELECT @msg = 'wrong_pwd'
	return



GO
