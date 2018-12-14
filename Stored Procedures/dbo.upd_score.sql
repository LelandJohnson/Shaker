SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	store overall score info in Applicant_Sessions
--				Usually an overall score but sometimes 2 additional main scores
--				that need to display in the applicant main admin view
-- History:		v1
--				v2 added optional Retake_Date
-- =============================================
CREATE PROCEDURE [dbo].[upd_score]
    (
		@Applicant_ID int,
		@Assessment_ID tinyint,
		@Session_ID tinyint,
		@Scoring_Version real,
		@Results_Overall tinyint,
		@Results_OtherValue1 tinyint,
		@Results_OtherValue2 tinyint,
		@Retake_Date datetime = null
		
    )
AS 
set nocount on

UPDATE [dbo].[Applicant_Sessions]
   SET [Scoring_Version] = @Scoring_Version
      ,[Results_Overall] = @Results_Overall
      ,[Results_OtherValue1] = @Results_OtherValue1
      ,[Results_OtherValue2] = @Results_OtherValue2
      ,[Retake_Date] = ISNULL(@Retake_Date, Retake_date) --if not supplied, keep original value
 WHERE Applicant_ID = @Applicant_ID and
	   Assessment_ID = @Assessment_ID and
	   Session_ID = @Session_ID
GO
