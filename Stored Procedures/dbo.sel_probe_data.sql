SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Retrieve work history probes by joining probes data with applicant's responses
--				note: no longer relies on Categories table as in old db
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_probe_data] (
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Session_ID tinyint 
)
AS

SELECT     Report_Probes.Report_Text, Report_Probes.Probe, Report_Probes.Category
FROM         Report_Probes INNER JOIN
                      Measures ON Report_Probes.Assessment_ID = Measures.Assessment_ID AND Report_Probes.Measure_Name = Measures.Measure_Name INNER JOIN
                      Applicant_Measures_Num ON Measures.Measure_ID = Applicant_Measures_Num.Measure_ID AND 
                      Applicant_Measures_Num.Value = Report_Probes.Response
WHERE     (Report_Probes.Assessment_ID = @Assessment_ID) AND (Applicant_Measures_Num.Applicant_ID = @Applicant_ID) AND 
                      (Applicant_Measures_Num.Session_ID = @Session_ID)
ORDER BY Report_Probes.Category_Order, Report_Probes.ItemOrder
GO
