SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get list of applicant data items and their choices
-- History:		v1 rollout, preset item choices only
--              v2 11/29/2011 includes distinct values from text and computed fields that have been saved in applicant_data
--					note Choice_ID retrieved and read by vjtserver but not currently used. could be removed for data size.
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_filters]
    (@Assessment_ID tinyint
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			
			--combine applicant_item_choices with dynamic list of entered values
			--preset item choices here, which map #'s to display values
SELECT       Applicant_Items.Item_ID "Item_ID",
			 Applicant_Items.Data_Title "Data_Title",
			 Applicant_Items.Item_Type "Item_Type",
			 Applicant_Items.Report_Label "Report_Label", 
             Applicant_Items.EEOC "EEOC",
             Applicant_Items.Conceal_Display "Conceal_Display",
             Applicant_Items.Allow_Filter "Allow_Filter",
             
             (select

               (select
				 cast(Applicant_Item_Choices.Store_Value as nvarchar(255))  "Store_Value",
				 Applicant_Item_Choices.Display_Text "Display_Text",
				 CAST(Applicant_Item_Choices.Choice_ID as nvarchar(255))  "Choice_ID"
				 from Applicant_Item_Choices 
				 where
				    Applicant_Item_Choices.Item_ID = Applicant_Items.Item_ID and
				    Applicant_Item_Choices.Assessment_ID = @Assessment_ID
				    
				for XML PATH('Applicant_Item_Choices'),  TYPE)
			,
				(select distinct Applicant_Data.Item_Value "Store_Value",
					   Applicant_Data.Item_Value "Display_Text",
					   Applicant_Data.Item_Value "Choice_ID"
					   from Applicant_Data where
					    Item_ID=Applicant_Items.Item_ID and Assessment_ID=@Assessment_ID
					    and (NOT (Item_Value IS NULL))
					    and Item_Type in ('RequisitionNum', 'Computed', 'TextBox')
				  					   
				
				 for XML PATH('Applicant_Item_Choices'),  TYPE)
				 
			 for xml path(''), TYPE)
			 
   		      
			              
FROM         Applicant_Items 

where Applicant_Items.Assessment_ID=@Assessment_ID


--(Applicant_Items.Item_Type IN ('RequisitionNum', 'Computed', 'TextBox')) AND (NOT (Applicant_Data.Item_Value IS NULL))


--ORDER BY Applicant_Items.Data_Title, Applicant_Data.Item_ID

 -- and Applicant_Items.Allow_Filter=1
 -- ORDER BY Applicant_Items.Display_Page, Applicant_Items.Display_Order,Applicant_Items.Item_ID, Applicant_Item_Choices.Display_Order
  
for xml PATH ('Applicant_Items')
END

GO
