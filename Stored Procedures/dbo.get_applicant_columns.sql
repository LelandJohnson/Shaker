SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get list of applicant data items to be displayed in grid
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_columns]
    (@Assessment_ID tinyint
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT       Applicant_Items.Item_ID, Applicant_Items.Data_Title,
				      Applicant_Items.Item_Type, Applicant_Items.Report_Label, 
                      Applicant_Items.EEOC, Applicant_Items.Conceal_Display
                      
FROM         Applicant_Items
where Applicant_Items.Assessment_ID=@Assessment_ID 
  
ORDER BY Applicant_Items.Display_Page, Applicant_Items.Display_Order
  
for xml auto, elements    
END
GO
