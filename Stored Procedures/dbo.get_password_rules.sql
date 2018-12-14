SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get password complexity rules for password reset
--				including previous hashes for disallowing previous pw's
-- History:		v1
-- Sync:		This sp is in the MCP database and each customer db, should be the same
-- =============================================
CREATE PROCEDURE [dbo].[get_password_rules]
    (@Admin_ID as varchar(50)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Policies.Disallow_Prev_Passwords, Administrators.[Password] AS PW_Hist_0, Administrators.PW_Hist_1, Administrators.PW_Hist_2, Administrators.PW_Hist_3, 
                      Administrators.PW_Hist_4, Policies.Min_Password_Length, Policies.Min_Number_Letters, Policies.Min_Number_Numbers, Policies.Min_Number_Special, 
                      Policies.Require_Mixed_Case
FROM         Administrators CROSS JOIN
                      Policies
WHERE     (Administrators.Admin_ID like @Admin_ID) AND (Policies.Selected_Policy = 1)
	
    
END
GO
