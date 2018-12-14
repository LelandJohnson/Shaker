SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


create PROCEDURE [dbo].[sel_Existing_LoginIDs] (
     @Login_ID VARCHAR(50),
     @First_Name VARCHAR(50) OUTPUT,
     @Last_Name VARCHAR(50) OUTPUT,
     @Applicant_ID integer OUTPUT,
     @Location_ID integer OUTPUT,
     @msg VARCHAR(10) OUTPUT
  	
    )
AS 
    IF @Login_ID IN ( SELECT    Login_ID
                      FROM      Applicants ) 
        BEGIN
            SELECT  @First_Name = First_Name,
                    @Last_Name = Last_Name,
                    @Applicant_ID = Applicant_ID
            FROM    Applicants
            WHERE   Login_ID = @Login_ID
            SELECT  @Location_ID = 1 -- ISNULL(MAX(Location_ID), -1)
         --   FROM    Test_er
         --   WHERE   Applicant_ID = @Applicant_ID
            SELECT  @msg = 'found'
         --   IF @Login_ID IN ( SELECT    Login_ID
         --                     FROM      Applicants
         --                     WHERE     [Applicants].[ClientOrderID] IS NOT NULL ) 
         --       SELECT  @msg = 'newPeopleScout'
         --   IF @Login_ID IN ( SELECT    Login_ID
         --                     FROM      Applicants
         --                     WHERE     [Applicants].[ClientOrderID] IS NOT NULL
         --                               AND [Applicants].[Password] = 'Password' ) 
         --       SELECT  @msg = 'newPeopleScout'
			
            RETURN
        END
    SELECT  @msg = 'missing'
    RETURN


GO
