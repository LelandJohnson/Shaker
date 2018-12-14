SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	insert applicant login record with browser info
--				return unique login identifier to be updated later
--				when more details are known in some cases.
--				this will allow the earliest possible record of a
--				visit even before browser info known, then fill in
--				browser info to the same event without adding new
--				logins.
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[ins_applicant_login]
           (@Applicant_ID int
           ,@Assessment_ID tinyint
           ,@Session_ID tinyint
           ,@Bookmark_at_Login varchar(9)
           ,@User_Agent varchar(500)
           ,@Flash_Version varchar(20)
           ,@System_Width smallint
           ,@System_Height smallint
           ,@Avail_Width smallint
           ,@Avail_Height smallint
           ,@Popup_OK bit
           ,@Sound_Test bit
           ,@HTTPS bit
           ,@Server_Name varchar(30)
           ,@Remote_IP varchar(40))
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[Applicant_Logins]
           ([Applicant_ID]
           ,[Assessment_ID]
           ,[Session_ID]
           ,[Timestamp]
           ,[Bookmark_at_Login]
           ,[User_Agent]
           ,[Flash_Version]
           ,[System_Width]
           ,[System_Height]
           ,[Avail_Width]
           ,[Avail_Height]
           ,[Popup_OK]
           ,[Sound_Test]
           ,[HTTPS]
           ,[Server_Name]
           ,[Remote_IP])
     VALUES
           (@Applicant_ID
           ,@Assessment_ID
           ,@Session_ID
           ,GETDATE()
           ,@Bookmark_at_Login
           ,@User_Agent
           ,@Flash_Version
           ,@System_Width
           ,@System_Height
           ,@Avail_Width
           ,@Avail_Height
           ,@Popup_OK
           ,@Sound_Test
           ,@HTTPS
           ,@Server_Name
           ,@Remote_IP)

--return Logon_EventID autonumber created
SELECT  SCOPE_IDENTITY() as [Logon_EventID]
           
END

GO
