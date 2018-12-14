SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	pass in assessment and text flag (0=numeric measures)
--				returns feedback measure list with "fbnum" numbering 1-n for export columns
--			    note: this performed slightly better than a View of similar functionality
-- History:		v1
-- =============================================
CREATE FUNCTION [dbo].[get_feedback_measure_function]
(
@Assessment_ID tinyint,
@Textual bit,
@Content_Version real = 1
)
RETURNS TABLE 
AS
RETURN 
(
SELECT    ROW_NUMBER() OVER (ORDER BY  Item_Order) AS 'fbnum',
 Measure_ID, Content_Version, Measure_Name, Textual, Assessment_ID
FROM         dbo.Measures
WHERE     (Section_Abbr = 'fb') and textual=@Textual and assessment_id=@Assessment_ID   and Content_Version=@Content_Version

)
GO
