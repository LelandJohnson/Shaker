SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE    PROCEDURE [dbo].[sel_applicant_pwd_ans] (
     @Login_ID varchar(50),
     @Position_ID TINYINT,
     @Password_Answer varchar(50),
     @msg varchar(10) OUTPUT
    )
AS 
SET NOCOUNT ON
    IF EXISTS ( SELECT  Login_ID
                FROM    Applicants
                Where   Login_ID like @Login_ID
                        AND Password_ResetA like @Password_Answer ) 
        BEGIN
            DECLARE @Applicant_ID INT
            SELECT  @Applicant_ID = Applicant_ID
            from    Applicants
            Where   Login_ID like @Login_ID
            
            IF NOT EXISTS ( SELECT  *
                            FROM    dbo.Applicant_Sessions
                            WHERE   [Applicant_ID] = @Applicant_ID
                                    AND Assessment_ID = @Position_ID ) 
                INSERT  INTO Applicant_Sessions (
                         Applicant_ID,
                         Assessment_ID,
                         Status_Code
                    
                        )
                VALUES  (
                          @Applicant_ID,
                          @Position_ID,
                          '0' )
            SELECT  @msg = 'match'  
            return
        END
    SELECT  @msg = 'wrong_ans'
    return


GO
