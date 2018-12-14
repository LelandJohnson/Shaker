SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	get info about applicant and session, will be the base columns for exports
--				pass in session filters (date, status code)
--				returns applicant, applicant_sessions, and applicant_data columns about user+session 
--				columns are abbreviated to reduce xml size (see below for legend)
--			    
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[export_applicant_sessioninfo_onereq]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint	
	)
	
AS
	SET NOCOUNT ON

 --aid			applicant id
 --TestID		assessment / vjt id
 --s			session number
 --r			req/transact id
 --fn			first name
 --ln			last name
 --id			login id/integration id
 --emp			employee id
 --id2			other id (like initials+last 4)
 --SC			status code
 --SDate		session start date
 --ASDate		applicant start date
 --ActivDate	last activity date
 --CDate		completion date
 --ttime		total time
 --qtime		question time
 --Score		overall score
 --scorever		scoring alg ver
 --cv			content ver
 --lang			language
 --altver		alt ver (like cc)
 --d1 - d32		applicant data items
 	
SELECT     aid, TestID, s, r, fn, ln, id, emp, id2, SC, SDate, ASDate, ActivDate, CDate, ttime, qtime, Score, scorever, cv, lang, altver, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, 
                      d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, d32
FROM         dbo.vw_export_basecolumns_onereq

WHERE     (testid = @Assessment_ID) and
		  ((@Start_Date_From is null) or (sdate>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or (sdate<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or (cdate>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or (cdate<=@Completion_Date_To)) and 
		  ( 
		  ((@Status_Code1 is null) or (SC = @Status_Code1)) and
		  ((@Status_Code2 is null) or (SC = @Status_Code2))
		  )		  


		 

GO
