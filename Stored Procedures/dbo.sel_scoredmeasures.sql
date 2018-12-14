SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- =============================================
-- Author:		jw
-- Description:	get numeric and text measures and their values
--				exluding unscored measures
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_scoredmeasures] (  

      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint
      )
AS 
begin

SELECT     m.Measure_Name as Measure_ID, mert.[Value], 't' as NorT
FROM         dbo.Applicant_Measures_Text mert join Measures m
 on mert.Measure_ID = m.Measure_ID
WHERE     (mert.Session_ID = @Session_ID) AND
		  (mert.Applicant_ID = @Applicant_ID) AND
		  (mert.Assessment_ID = @Assessment_ID) AND
		  (not (m.Unscored = 1))

UNION

SELECT     m.Measure_Name as Measure_ID, CAST(mer.[Value] as varchar(50)), 'n' as NorT
FROM         dbo.Applicant_Measures_Num mer join Measures m
 on mer.Measure_ID = m.Measure_ID
WHERE     (mer.Session_ID = @Session_ID) AND
		  (mer.Applicant_ID = @Applicant_ID) AND
		  (mer.Assessment_ID = @Assessment_ID) AND
		  (not (m.Unscored = 1))


                  
end







GO
