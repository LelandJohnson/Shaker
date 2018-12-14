SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve work history probes by joining probes data with applicant's responses
--				note: no longer relies on Categories table as in old db
-- History:		v1
--				v2 Returns measure name + response to look up translated text (for French report)
--				   could also have added language column but could have affected other apps.
-- =============================================
CREATE PROCEDURE [dbo].[sel_probe_data_xml] (
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint 
)
AS

SELECT     Report_Probes.Report_Text, Report_Probes.Probe, Report_Probes.Category, Report_Probes.Measure_Name, Report_Probes.Response
FROM         Report_Probes INNER JOIN
                      Measures ON Report_Probes.Assessment_ID = Measures.Assessment_ID AND Report_Probes.Measure_Name = Measures.Measure_Name INNER JOIN
                      Applicant_Measures_Num ON Measures.Measure_ID = Applicant_Measures_Num.Measure_ID AND 
                      Applicant_Measures_Num.Value = Report_Probes.Response
WHERE     (Report_Probes.Assessment_ID = @Assessment_ID) AND (Applicant_Measures_Num.Applicant_ID = @Applicant_ID) AND 
                      (Applicant_Measures_Num.Session_ID = @Session_ID)
ORDER BY Report_Probes.Category_Order, Report_Probes.ItemOrder
for xml auto, elements
GO
