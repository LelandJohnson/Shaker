SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get info about login times and browser/system info
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_logins]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint = 1,
	@Session_ID tinyint
	)
	
AS
SET NOCOUNT ON


SELECT     Session_ID, convert(nvarchar(100),[Timestamp],20) as [Timestamp], Bookmark_at_Login, User_Agent, Flash_Version, (CAST(System_Width as varchar(6)) + 'x' + CAST(System_Height as varchar(6))) as MaxDim, 
           (CAST(Avail_Width as varchar(6)) + 'x' + CAST(Avail_Height as varchar(6))) as AvailDim, Popup_OK, Sound_Test, HTTPS, Server_Name
FROM       Applicant_Logins

WHERE     (Applicant_ID = @Applicant_ID) AND (Assessment_ID = @Assessment_ID) --AND (Session_ID = @Session_ID) --no session constraint yet, not being recorded.

order by [timestamp]

for xml auto, elements
GO
