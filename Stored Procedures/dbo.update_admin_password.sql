SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Update admin password
--				Pass in admin id and pw hash
-- History:		v1
--				v2 - removed [MasterControl] reference so it works correctly on client db admins
--				v3 - checks current password first and returns OK or not
-- Sync:		This sp is in the MCP database and each customer db, should be the same
-- =============================================
CREATE PROCEDURE [dbo].[update_admin_password]
    (
      @Admin_ID AS VARCHAR(50) ,
      @NewPassword AS VARCHAR(64) ,
      @CurrentPassword AS VARCHAR(64) = NULL
    )
AS 
    BEGIN

        SET NOCOUNT ON;

        DECLARE @PWOk BIT
        SET @PWok = 1 --default to skipping pw check, so if sp's are updated before vjtserver it will still work


        IF NOT ( @CurrentPassword IS NULL ) 
            BEGIN
                SELECT  @PWok = CASE WHEN dbo.Administrators.[Password] LIKE @CurrentPassword
                                     THEN 1
                                     ELSE 0
                                END
                FROM    dbo.Administrators
                WHERE   Admin_ID LIKE @Admin_ID

   

            END


--set previous history of pw's
--and new active password, and reset pw date
        IF @PWOk = 1 
            BEGIN
                UPDATE  [dbo].[Administrators]
                SET     PW_Hist_4 = PW_Hist_3 ,
                        PW_Hist_3 = PW_Hist_2 ,
                        PW_Hist_2 = PW_Hist_1 ,
                        PW_Hist_1 = [Password] ,
                        [Password] = @NewPassword ,
                        Password_Date = GETDATE()
                WHERE   Admin_ID LIKE @Admin_ID

    
            END


--returns ok or not
        SELECT  CASE WHEN @PWOk = 1 THEN 'OK'
                     ELSE 'INCORRECT'
                END AS Result_Code
    END
GO
