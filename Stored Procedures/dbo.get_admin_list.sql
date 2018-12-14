SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Retrieve list of administrators
--				for superuser / adminlist tabs in security center
-- History:		v1
-- Sync:		This sp is in the MCP database and each customer db, should be the same
-- =============================================
CREATE PROCEDURE [dbo].[get_admin_list]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Admin_ID, First_Name, Last_Name, Active, convert(nvarchar(100),Last_Login_Date,20) as Last_Login_Date , convert(nvarchar(100), Locked_Until_Date,20) as Locked_Until_Date
FROM         Administrators
order by Last_Name, First_Name
for xml auto, elements
END
GO
