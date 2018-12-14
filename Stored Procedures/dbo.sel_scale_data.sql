SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	old style dfr report scale records
-- History:		v1
--				v2: added @SortOrder to allow retrieval of top or bottom scores.
--					added Tiebreaker column sort
-- =============================================


CREATE PROCEDURE [dbo].[sel_scale_data]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Session_ID TINYINT ,
      @Scoring_Version REAL ,
      @SortOrder TINYINT = 1
    )
AS 
    SET NOCOUNT ON

    SELECT  [Scale] ,
            [Scale_Score] --,dbo.Report_Configuration.Value 
    FROM    dbo.[Scale_Scores]
            LEFT OUTER JOIN dbo.Report_Configuration ON dbo.Scale_Scores.Assessment_ID = dbo.Report_Configuration.Assessment_ID
                                                        AND 'TB_'
                                                        + dbo.Scale_Scores.Scale = dbo.Report_Configuration.Report_Variable
    WHERE   Applicant_ID = @Applicant_ID
            AND Scale_Scores.Assessment_ID = @Assessment_ID
            AND Session_ID = @Session_ID
            AND @Scoring_Version = @Scoring_Version
    ORDER BY CASE WHEN @SortOrder = 1 THEN [Scale_Score]
             END ,
            CASE WHEN @SortOrder = 1 THEN dbo.Report_Configuration.Value
            END ,
            CASE WHEN @SortOrder = 2 THEN [Scale_Score]
            END DESC ,
            CASE WHEN @SortOrder = 2 THEN dbo.Report_Configuration.Value
            END 
GO
