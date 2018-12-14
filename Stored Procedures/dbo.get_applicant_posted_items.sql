SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get applicant data items xml info for integration aor posts
--              or signon page submit (not render)
-- History:		v1 rollout, mostly for kpmg kbr posts
--
--				v2 added Integration Attribute value to match on for Taleo / Directv
				
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_posted_items]
	
	(
	@Assessment_ID tinyint = 1
	)
	
AS

SET NOCOUNT ON

SELECT     [items].Item_ID, [items].Data_Title, [types].Item_Type,
					 [items].Integration_XML_CDATA as [cdata], [items].Integration_XML_Node as [node], 
                     [items].Integration_XML_NodeChildren as [children], [items].Integration_XML_Attribute as [attr], [items].Integration_XML_AttributeValue as [attrval],
                     [items].Integration_Form_Name as [form], 
                     [items].Integration_Form_Field as [formfield]
FROM         Applicant_Items [items] LEFT JOIN
                      Applicant_Item_Types [types] ON [items].Item_Type = [types].Item_Type
WHERE items.Assessment_ID = @Assessment_ID                      
for xml auto, elements








GO
