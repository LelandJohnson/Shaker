SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get applicant info about person and session
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_measures]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint = 1,
	@Session_ID tinyint
	)
	
AS
	SET NOCOUNT ON


SELECT     Applicant_ID, Assessment_ID, Session_ID, Measure_ID, CAST([Value] AS VARCHAR(4000)) AS [Value] into #tempresponses
FROM         Applicant_Measures_Num
WHERE     (Applicant_ID = @Applicant_ID) AND (Session_ID = @Session_ID) AND (Assessment_ID = @Assessment_ID)
UNION
SELECT     Applicant_ID, Assessment_ID, Session_ID, Measure_ID, Value
FROM         Applicant_Measures_Text
WHERE     (Applicant_ID = @Applicant_ID) AND (Session_ID = @Session_ID) AND (Assessment_ID = @Assessment_ID)

--join response list with full measure list
SELECT     ml.Measure_Name, ml.Measure_ID, ml.Section_Abbr,  ISNULL(#tempresponses.Value,'n/a') AS [Value]
FROM         Measures ml LEFT OUTER JOIN
                      #tempresponses ON ml.Measure_ID = #tempresponses.Measure_ID 
WHERE     (ml.Content_Version = 1 and ml.Assessment_ID=@Assessment_ID)
order by section_order, item_order
for xml auto

--temp table will be removed automatically but manual removal recommended:
drop table #tempresponses




GO
