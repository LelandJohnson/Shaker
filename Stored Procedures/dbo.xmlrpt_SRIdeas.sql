SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	xmlrpt_SRIdeas
--				return user's SR ideas to fill SR probes report
--				pass in like clause that will retrieve all sr entries
--				like 
--				return xml with all sr items' ideas
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[xmlrpt_SRIdeas]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@MeasureLike varchar(50)
	)
	
AS
SET NOCOUNT ON

SELECT       mt.Value as txt, Measures.Measure_Name
FROM         Applicant_Measures_Text mt INNER JOIN
                      Measures ON mt.Measure_ID = Measures.Measure_ID
WHERE     (mt.Applicant_ID = @Applicant_ID) AND
 (mt.Assessment_ID = @Assessment_ID) and 
 (mt.Session_ID = @Session_ID) and
 (Measures.Measure_Name LIKE @MeasureLike)
order by Measures.Item_Order

for xml auto
GO
