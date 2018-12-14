SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	login event already created but without browser
--				details, the same row can be updated with this
--				sp as more details are known.
--				if details are blank, do not replace existing values.
--				only included fields that are not written via server vars.
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[upd_applicant_login]
           (@Login_EventID int
           ,@Flash_Version varchar(20)
           ,@System_Width smallint
           ,@System_Height smallint
           ,@Avail_Width smallint
           ,@Avail_Height smallint
           ,@Popup_OK bit
           ,@Sound_Test bit
           ,@Server_Name varchar(30)
)
AS
BEGIN
	SET NOCOUNT ON;

--case statements prevent replacing already filled-in values with null if not supplied this time
--so sound_test and popup_ok can be updated later after flash and screen info without resubmitting all data
UPDATE [dbo].[Applicant_Logins]
   SET [Flash_Version] = case when @Flash_Version is not null THEN @Flash_Version else Flash_Version END
      ,[System_Width] = case when @System_Width is not null THEN @System_Width else System_Width END
      ,[System_Height] = case when @System_Height is not null THEN @System_Height else System_Height END
      ,[Avail_Width] = case when @Avail_Width is not null THEN @Avail_Width else Avail_Width END
      ,[Avail_Height] = case when @Avail_Height is not null THEN @Avail_Height else Avail_Height END
      ,[Popup_OK] = case when @Popup_OK is not null THEN @Popup_OK else Popup_OK END
      ,[Sound_Test] = case when @Sound_Test is not null THEN @Sound_Test else Sound_Test END
      ,[Server_Name] = case when @Server_Name is not null THEN @Server_Name else Server_Name END

 WHERE Logon_EventID = @Login_EventID;
 
           
END

GO
