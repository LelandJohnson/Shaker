SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	create or update applicant record
--              return applicant_id
-- History:		v1
--				v2 if null password & reset q/a passed in,
--				   leave unchanged. (for new applicant signin
--				   where returning users can update their info
--				   but don't have to update their password)
--				v3 Other_ID support added for another perm attribute
--				   that won't need to be position or session specific
--				   (defaults to null if omitted)
-- =============================================
CREATE                 PROCEDURE [dbo].[ins_applicant]
    (

      @Login_ID VARCHAR(50) ,
      @Last_Name VARCHAR(50) ,      
      @First_name VARCHAR(50) ,
      @Middle_Initial VARCHAR(50) ,
      @Email VARCHAR(75) ,
      @Phone VARCHAR(20) ,
	  @Employee_ID varchar(20) ,       
      @Password VARCHAR(64) ,      
      @Password_Question TINYINT ,
      @Password_Answer VARCHAR(50) ,
      @Password_Hint varchar(255),
      @Other_ID varchar(20) = null       
    )
AS 
set nocount on

    DECLARE @Applicant_ID INT
    IF NOT EXISTS ( SELECT  *
                    FROM    dbo.Applicants
                    WHERE   Login_ID LIKE @Login_ID ) 
        BEGIN


			INSERT INTO [dbo].[Applicants]
					   ([Login_ID]
					   ,[Last_Name]
					   ,[First_Name]
					   ,[Middle_Initial]
					   ,[Email]
					   ,[Phone]
					   ,[Employee_ID]
					   ,[Password]
					   ,[Password_ResetQ]
					   ,[Password_ResetA]
					   ,[Password_Hint]
					   ,[Other_ID]
					   )
				 VALUES
					   (
						  @Login_ID,
						  @Last_Name,
						  @First_name,
						  @Middle_Initial,
						  @Email,
						  @Phone,
						  @Employee_ID,
						  @Password,
						  @Password_Question,
						  @Password_Answer,
						  @Password_Hint,
						  @Other_ID
					   )


                        
            SELECT  @Applicant_ID = SCOPE_IDENTITY() 
            

        END
    ELSE 
        BEGIN
			--Login_ID earlier establishes uniqueness
			--for returning users, when null passed in
			--for password and reset q/a, leave unchanged
			
            SET nocount ON
           
			UPDATE [dbo].[Applicants]
			   SET 
				  [Last_Name] = @Last_Name,
				  [First_Name] = @First_name,
				  [Middle_Initial] = @Middle_Initial,
				  [Email] = @Email,
				  [Phone] = @Phone,
				  [Employee_ID] = @Employee_ID,
				  [Password] = ISNULL(@Password, [Password]),
				  [Password_ResetQ] = ISNULL( @Password_Question,[Password_ResetQ]),
				  [Password_ResetA] = ISNULL( @Password_Answer, [Password_ResetA]),
				  [Password_Hint] = ISNULL(@Password_Hint, [Password_Hint]),
				  [Other_ID] = ISNULL(@Other_ID, [Other_ID])
            WHERE   Login_ID LIKE @Login_ID
            
            SELECT  @Applicant_ID = Applicant_ID
            FROM    dbo.Applicants
            WHERE   Login_ID LIKE @Login_ID
            
        END

select @Applicant_ID as Applicant_ID













GO
