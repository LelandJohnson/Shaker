SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Object:  Stored Procedure dbo.ins_Applicant    Script Date: 11/3/2005 10:47:37 AM ******/
CREATE                 PROCEDURE [dbo].[ins_Applicant_standin]
    (
      @val INT OUTPUT ,
      @Position_ID TINYINT ,
      @Login_ID VARCHAR(50) ,
      @Password VARCHAR(50) ,
      @First_name VARCHAR(50) ,
      @Middle_Initial CHAR(2) ,
      @Last_Name VARCHAR(50) ,
      @email_addr VARCHAR(80) ,
      @phone VARCHAR(80) ,
      @Password_Question TINYINT ,
      @Password_Answer VARCHAR(50) ,
      @EmployeeID VARCHAR(20) 
    )
AS 
SET nocount OFF
    IF NOT EXISTS ( SELECT  *
                    FROM    dbo.Applicants
                    WHERE   Login_ID LIKE @Login_ID ) 
        BEGIN
            DECLARE @Applicant_ID INT
            INSERT  INTO Applicants
                    ( Login_ID ,
                      [Password] ,
                      First_name ,
                      Middle_Initial ,
                      Last_Name ,
                      email ,
                      phone ,
                      Password_ResetQ ,
                      Password_ResetA ,
                      Employee_ID                       
                    )
            VALUES  ( @Login_ID ,
                      @Password ,
                      @First_name ,
                      @Middle_Initial ,
                      @Last_Name ,
                      @email_addr ,
                      @phone ,
                      @Password_Question ,
                      @Password_Answer ,
                      @EmployeeID 
                    )
                        
            SELECT  @val = SCOPE_IDENTITY() 
       
            INSERT INTO dbo.Applicant_Sessions
                    ( Applicant_ID ,
                      Assessment_ID ,
                      Session_ID ,
                      Status_Code ,
                      Elapsed_Time,
                      Question_Time,
                      Location_ID ,
					  Start_Date ,
                       Section_Time_Remaining
                       
                    )
            VALUES  ( @val , -- Applicant_ID - int
                      @Position_ID , -- Assessment_ID - tinyint
                      1 , -- Session_ID - tinyint
                      1,  -- Status_Code - smallint
                      0, --elapsed time, init times to 0 because it couldn't add numbers to NULL
                      0 ,  --question time 
                      1,
                      GETDATE(),
                      -1
                    ) 
            RETURN @@rowcount
        END
    ELSE 
        BEGIN
			--Login_ID earlier establishes uniqueness
			--password reset uses User Info screen 
            SET nocount ON
            UPDATE  Applicants
            SET     [Password] = @Password ,
                    First_name = @First_name ,
                    Middle_Initial = @Middle_Initial ,
                    Last_Name = @Last_Name ,
                    email = @email_addr ,
                    phone = @phone ,
                    Password_ResetQ = @Password_Question ,
                    Password_ResetA = @Password_Answer ,
                    Employee_ID = @EmployeeID 
            WHERE   Login_ID LIKE @Login_ID
            SELECT  @val = Applicant_ID
            FROM    dbo.Applicants
            WHERE   Login_ID LIKE @Login_ID
            
            IF NOT EXISTS ( SELECT  *
                    FROM    dbo.Applicant_Sessions
                    WHERE   Applicant_ID = @val AND Assessment_ID = @Position_ID )
                    BEGIN
                    INSERT INTO dbo.Applicant_Sessions
                    ( Applicant_ID ,
                      Assessment_ID ,
                      Session_ID ,
                      Status_Code ,
                      Elapsed_Time,
                      Question_Time,
                      Location_ID ,
					  Start_Date ,
                       Section_Time_Remaining
                    )
            VALUES  ( @val , -- Applicant_ID - int
                      @Position_ID , -- Assessment_ID - tinyint
                      1 , -- Session_ID - tinyint
                      1,  -- Status_Code - smallint
                      0, --elapsed time, init times to 0 because it couldn't add numbers to NULL
                      0,  --question time 
                      1,
                      GETDATE(),
                      -1
                    ) 
                    END
            
            RETURN @@rowcount
            
        END













GO
