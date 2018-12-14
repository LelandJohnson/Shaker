SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	old style dfr report records
-- History:		v1
-- =============================================


CREATE PROCEDURE [dbo].[sel_devfbk_text] 
(@Assessment_ID tinyint,
 @Scoring_Version real,
 @Language_Code varchar(24) = 'en-US')
AS 
SET NOCOUNT ON

SELECT     Category_Order, Comp_Order, Scale_Order, Scale, Low_Bullet, High_Bullet, Competency, Category
FROM         DevFeedback_Scales
WHERE     (Assessment_ID = @Assessment_ID) and (Scoring_Version=@Scoring_Version) and (Language_Code like @Language_Code)
ORDER BY Category_Order, Comp_Order, Scale_Order
GO
