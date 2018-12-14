SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sel_measures] (
      @Session_ID tinyint,  
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Measure_Names varchar(255) 
--@Measure_Names is a comma delimited list of measures to retrieve
--also begin and eng with comma.
--underscores in measureid's will result in additional matches but extra matches cause no harm where this is used in the application.
)
AS
SELECT     m.Measure_Name, am.Value as Response
FROM         dbo.Applicant_Measures_Num am join dbo.Measures m on am.Measure_ID = m.Measure_ID
WHERE     (am.Session_ID = @Session_ID) AND (am.Applicant_ID = @Applicant_ID) AND (am.Assessment_ID = @Assessment_ID) AND (PATINDEX('%,' + m.Measure_Name+',%', @Measure_Names) > 0)
GO
