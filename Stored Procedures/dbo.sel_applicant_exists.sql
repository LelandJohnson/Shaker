SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Look up applicant loginid
--				during log in sequence, determine
--				if new or returning for password/signup prompt
--				
-- History:		v1
--				v2 - added pw reset q & a for refilling a_new_info screen
--				v3 - added employee_id and other_id if needed on a_new_info
-- Sync:		none
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant_exists]
    (@Login_ID as varchar(50)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT Login_ID, First_Name, Last_Name, Applicant_ID, Password_ResetQ, Password_ResetA, Employee_ID, Other_ID
 from Applicants
 where Login_ID like @Login_ID 

END
GO
