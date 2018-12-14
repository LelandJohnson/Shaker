SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get list of applicant data items and their choices
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_filters_nonxml]
    (@Assessment_ID tinyint
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT       Applicant_Items.Item_ID, Applicant_Items.Data_Title, Applicant_Items.Item_Type, Applicant_Items.Report_Label, 
                      Applicant_Items.EEOC, Applicant_Items.Conceal_Display, Applicant_Items.Allow_Filter,
                      cast(Applicant_Item_Choices.Store_Value as nvarchar(255)) as Store_Value, Applicant_Item_Choices.Display_Text,
                      CAST(Applicant_Item_Choices.Choice_ID as nvarchar(255)) as Choice_ID
FROM         Applicant_Items LEFT JOIN
                      Applicant_Item_Choices ON Applicant_Items.Assessment_ID = Applicant_Item_Choices.Assessment_ID AND 
                      Applicant_Items.Item_ID = Applicant_Item_Choices.Item_ID

where Applicant_Items.Assessment_ID=@Assessment_ID

union

SELECT  distinct
                      Applicant_Data.Item_ID, Applicant_Items.Data_Title, Applicant_Items.Item_Type, Applicant_Items.Report_Label, Applicant_Items.EEOC, 
                      Applicant_Items.Conceal_Display, Applicant_Items.Allow_Filter, Applicant_Data.Item_Value AS Store_Value, Applicant_Data.Item_Value AS Display_Text, 
                      Applicant_Data.Item_Value AS Choice_ID
FROM         Applicant_Data INNER JOIN
                      Applicant_Items ON Applicant_Data.Assessment_ID = Applicant_Items.Assessment_ID AND Applicant_Data.Item_ID = Applicant_Items.Item_ID
WHERE     (Applicant_Data.Assessment_ID = 1) AND (Applicant_Items.Item_Type IN ('RequisitionNum', 'Computed', 'TextBox')) AND (NOT (Applicant_Data.Item_Value IS NULL))


--ORDER BY Applicant_Items.Data_Title, Applicant_Data.Item_ID

 -- and Applicant_Items.Allow_Filter=1
 -- ORDER BY Applicant_Items.Display_Page, Applicant_Items.Display_Order,Applicant_Items.Item_ID, Applicant_Item_Choices.Display_Order
  
--for xml auto, elements    
END
GO
