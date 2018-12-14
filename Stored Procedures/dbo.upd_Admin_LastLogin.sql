SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Update admin last login field with current date
-- History:		v1
-- Sync:		This sp is in the MCP database and each customer db, should be the same
-- =============================================
CREATE PROCEDURE [dbo].[upd_Admin_LastLogin]
    (@Admin_ID as varchar(50)
    )
AS
BEGIN
	-- LEAVE NOCOUNT OFF so it returns number of rows affected
	-- SET NOCOUNT ON;

UPDATE [dbo].[Administrators]
   SET [Last_Login_Date] = GETDATE()
 WHERE Admin_ID like @Admin_ID;
 

	
    
END
GO
