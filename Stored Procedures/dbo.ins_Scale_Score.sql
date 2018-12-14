SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	old style scale recording to drive DFR
-- History:		v1
-- =============================================


CREATE PROCEDURE [dbo].[ins_Scale_Score] 
(@Applicant_ID int,
@Assessment_ID tinyint,
@Session_ID tinyint,
@Scoring_Version real,
@Scale varchar(100), 
@Score float)
AS 
SET NOCOUNT ON

IF EXISTS (select * from dbo.Scale_Scores where Session_ID = @Session_ID and Applicant_ID = @Applicant_ID and Scale = @Scale and Assessment_ID = @Assessment_ID
 and Scoring_Version = @Scoring_Version) 
      BEGIN 
      UPDATE  Scale_Scores
      SET Scale_Score = @Score
      where Session_ID = @Session_ID
      and Applicant_ID = @Applicant_ID
      and Scale = @Scale 
      and Assessment_ID = @Assessment_ID and
      Scoring_Version = @Scoring_Version
      end
      
ELSE
      BEGIN
      insert into dbo.Scale_Scores (Scale, Session_ID, Applicant_ID, Assessment_ID, Scale_Score, Scoring_Version)
      values(@Scale, @Session_ID,@Applicant_ID,@Assessment_ID,@Score, @Scoring_Version)

      end

      
GO
