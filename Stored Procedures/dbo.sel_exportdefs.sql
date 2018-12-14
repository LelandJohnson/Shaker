SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
2018 dec 5 - cast varchar max to varchar 8000
*/
CREATE PROCEDURE [dbo].[sel_exportdefs]
    (
      @Test_ID INT ,
      @Scoring_Version REAL
    )
AS 
    BEGIN

        SELECT  Assessment_ID,
                Export_ID,
                Scoring_Version,
                CAST(Header_Row AS VARCHAR(8000)) AS Header_Row
        FROM    dbo.Export_Definitions
        WHERE   Assessment_ID = @Test_ID
                AND Scoring_Version = @Scoring_Version
                 
    END
GO
