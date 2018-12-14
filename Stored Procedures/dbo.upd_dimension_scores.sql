SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Insert/Update collection of dimension scores
--				pass in xml containing rows of:
--				Applicant_ID, Assessment_ID, Dimension_ID,Scoring_Version,Session_ID, Dimension_Score
--				in the format:
--				<xml>
--				  <dimscore applid="1" assid="1" dimid="1" ver="1" sessionid="1" score="3" />
--				  <dimscore applid="1" assid="1" dimid="2" ver="1" sessionid="1" score="1" />
--				  <dimscore applid="1" assid="1" dimid="3" ver="1" sessionid="1" score="4" />
--				</xml>
--				
--				Can be any number of dimscores but dimid="x"'s need to exist in Dimensions table
--
--				This is one method of passing in a list of unknown length to a stored procedure.
--				(Each vjt would have a different number of scored competencies/dimensions)
--				It works in sql server 2005.  A better method requires 2008 which is only on my
--				dev machine and production. (table-value parameter (TVP's))
--				Also note scg prefers the term competencies but using dimensions here for tradition
-- History:		v1
-- =============================================

CREATE PROCEDURE [dbo].[upd_dimension_scores] (
   @dims xml,
   @Applicant_ID  int,
   @Assessment_ID tinyint,
   @Session_ID tinyint,
   @Scoring_Version real
   )
    AS

if not exists (
   SELECT Applicant_ID, Dimension_Score
   FROM   Dimension_Scores d
   JOIN   @dims.nodes('/xml/dimscore') AS T(Item)
     ON   d.Applicant_ID = @Applicant_ID and
		  d.Assessment_ID = @Assessment_ID and
		  d.Dimension_ID = T.Item.value('@dimid[1]', 'tinyint') and
		  d.Scoring_Version = @Scoring_Version and
		  d.Session_ID = @Session_ID
   
   )
   begin
      --insert
		insert Dimension_Scores (Applicant_ID, Assessment_ID, Dimension_ID,Scoring_Version,Session_ID, Dimension_Score)
		select 
			@Applicant_ID,
			@Assessment_ID,
			T.Item.value('@dimid[1]', 'tinyint'),
			@Scoring_Version,
			@Session_ID,
			T.Item.value('@score[1]', 'tinyint')
	    from @dims.nodes('/xml/dimscore') AS T(Item)
		  		
   end
else
   begin
--	  --update
      update Dimension_Scores set Dimension_Score = T.Item.value('@score[1]', 'tinyint')
      from Dimension_Scores d inner join @dims.nodes('/xml/dimscore') as T(Item)
      on  d.Applicant_ID = @Applicant_ID and
		  d.Assessment_ID = @Assessment_ID and
		  d.Dimension_ID = T.Item.value('@dimid[1]', 'tinyint') and
		  d.Scoring_Version = @Scoring_Version and
		  d.Session_ID = @Session_ID

   end
     
GO
