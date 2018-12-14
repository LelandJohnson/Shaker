SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Retrieve administrator settings
--				admin prefs are stored only in the customer databases, so preferences can vary from vjt to vjt.
--				for example the default date range might be smaller for higher volume systems, or some customers we are
--				constantly editing recruiter data to the security center is the default view.
--				as such, not the Admin_Preferences table has no foreign key relationship for Admin_ID, since some admins
--				reside in the MasterControl database.
-- History:		v1
-- Sync:		no
-- =============================================
CREATE PROCEDURE [dbo].[get_admin_preferences]
(@Admin_ID varchar(50),
 @Assessment_ID tinyint )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Administrator_Preferences.Time_Zone, Administrator_Preferences.Default_View, Administrator_Preferences.Dashboard_View,  
                      Administrator_Preferences.Default_DateRange, Administrator_Preferences.Default_DoubleClick_Action, Administrator_DataGridColumns.Applicant_Item_List
FROM         Administrator_Preferences LEFT OUTER JOIN
                      Administrator_DataGridColumns ON Administrator_Preferences.Admin_ID = Administrator_DataGridColumns.Admin_ID
WHERE     (Administrator_Preferences.Admin_ID LIKE @Admin_ID) AND ((Administrator_DataGridColumns.Assessment_ID = @Assessment_ID) or (Administrator_DataGridColumns.Assessment_ID is null) )

END
GO
