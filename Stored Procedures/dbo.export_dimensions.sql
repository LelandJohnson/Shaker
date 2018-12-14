SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns applicant, applicant_sessions, and applicant_data columns about user+session 
--				and dimension scores corresponding to users' scoring version.
--				perform a check that columns are compatible if range spans multiple scoring version (so column headers end up correct)
--			    
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[export_dimensions]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint,
	@cv float = 1,	--content version, not used for dim export but maintain standard set of params for exports.
	@reqtreatment varchar(16) = 'all' --how to decide which req(s) to show, 'all' 'latest' or 'kpmg' style		
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
 --lang			language
 --altver		alt ver (like cc)
 --d1 - d32		applicant data items


 
 
 
	--set up temp table #fromview that is one of the vw_export views with different treatments of multiple reqs and applicant data columns
	--(temp table defeated table variable in performance test)

CREATE TABLE #fromview 
(
[aid] int, [TestID] tinyint, [s] tinyint, [r] varchar(50), [fn] nvarchar(50), [ln] nvarchar(50), [id] varchar(50), [emp] varchar(20),
[id2] varchar(20), [SC] smallint, [SDate] nvarchar(100), [ASDate] nvarchar(100), [ActivDate] nvarchar(100), [CDate] nvarchar(100),
[ttime] int, [qtime] int, [Score] tinyint, [scorever] real, [cv] real, [lang] varchar(24), [altver] tinyint,
[d1] nvarchar(255), [d2] nvarchar(255), [d3] nvarchar(255), [d4] nvarchar(255),
[d5] nvarchar(255), [d6] nvarchar(255), [d7] nvarchar(255), [d8] nvarchar(255),
[d9] nvarchar(255), [d10] nvarchar(255), [d11] nvarchar(255), [d12] nvarchar(255),
[d13] nvarchar(255), [d14] nvarchar(255), [d15] nvarchar(255), [d16] nvarchar(255),
[d17] nvarchar(255), [d18] nvarchar(255), [d19] nvarchar(255), [d20] nvarchar(255),
[d21] nvarchar(255), [d22] nvarchar(255), [d23] nvarchar(255), [d24] nvarchar(255),
[d25] nvarchar(255), [d26] nvarchar(255), [d27] nvarchar(255), [d28] nvarchar(255),
[d29] nvarchar(255), [d30] nvarchar(255), [d31] nvarchar(255), [d32] nvarchar(255) 
) 

if @reqtreatment = 'all'
	INSERT INTO #fromview
	select * from dbo.vw_export_basecolumns
           	
if @reqtreatment = 'latest'
	INSERT INTO #fromview
	select * from dbo.vw_export_basecolumns_onereq

if @reqtreatment = 'kpmg'
	INSERT INTO #fromview
	select * from dbo.vw_export_basecolumns_onereq_kpmg
 	
 

 	
SELECT     xr.aid, xr.TestID, xr.s, xr.r, xr.fn, 
                      xr.ln, xr.id, xr.emp, xr.id2, xr.SC, 
                      xr.SDate, xr.ASDate, xr.ActivDate, xr.CDate, 
                      xr.ttime, xr.qtime, xr.Score, xr.scorever, xr.cv, xr.lang, 
                      xr.altver, xr.d1, xr.d2, xr.d3, xr.d4, 
                      xr.d5, xr.d6, xr.d7, xr.d8, xr.d9, 
                      xr.d10, xr.d11, xr.d12, xr.d13, xr.d14, 
                      xr.d15, xr.d16, xr.d17, xr.d18, xr.d19, 
                      xr.d20, xr.d21, xr.d22, xr.d23, xr.d24, 
                      xr.d25, xr.d26, xr.d27, xr.d28, xr.d29, 
                      xr.d30, xr.d31, xr.d32,

    MAX(CASE WHEN (dimscore.Dimension_ID = 1) then dimscore.Dimension_Score else null END) as dim1,
	MAX(CASE WHEN (dimscore.Dimension_ID = 2) then dimscore.Dimension_Score else null END) as dim2,
	MAX(CASE WHEN (dimscore.Dimension_ID = 3) then dimscore.Dimension_Score else null END) as dim3,
    MAX(CASE WHEN (dimscore.Dimension_ID = 4) then dimscore.Dimension_Score else null END) as dim4,
	MAX(CASE WHEN (dimscore.Dimension_ID = 5) then dimscore.Dimension_Score else null END) as dim5,
	MAX(CASE WHEN (dimscore.Dimension_ID = 6) then dimscore.Dimension_Score else null END) as dim6,
    MAX(CASE WHEN (dimscore.Dimension_ID = 7) then dimscore.Dimension_Score else null END) as dim7,
	MAX(CASE WHEN (dimscore.Dimension_ID = 8) then dimscore.Dimension_Score else null END) as dim8,
	MAX(CASE WHEN (dimscore.Dimension_ID = 9) then dimscore.Dimension_Score else null END) as dim9,
    MAX(CASE WHEN (dimscore.Dimension_ID = 10) then dimscore.Dimension_Score else null END) as dim10,                      
    MAX(CASE WHEN (dimscore.Dimension_ID = 11) then dimscore.Dimension_Score else null END) as dim11,
	MAX(CASE WHEN (dimscore.Dimension_ID = 12) then dimscore.Dimension_Score else null END) as dim12,
	MAX(CASE WHEN (dimscore.Dimension_ID = 13) then dimscore.Dimension_Score else null END) as dim13,
    MAX(CASE WHEN (dimscore.Dimension_ID = 14) then dimscore.Dimension_Score else null END) as dim14,
	MAX(CASE WHEN (dimscore.Dimension_ID = 15) then dimscore.Dimension_Score else null END) as dim15,
	MAX(CASE WHEN (dimscore.Dimension_ID = 16) then dimscore.Dimension_Score else null END) as dim16,
    MAX(CASE WHEN (dimscore.Dimension_ID = 17) then dimscore.Dimension_Score else null END) as dim17,
	MAX(CASE WHEN (dimscore.Dimension_ID = 18) then dimscore.Dimension_Score else null END) as dim18,
	MAX(CASE WHEN (dimscore.Dimension_ID = 19) then dimscore.Dimension_Score else null END) as dim19,
    MAX(CASE WHEN (dimscore.Dimension_ID = 20) then dimscore.Dimension_Score else null END) as dim20,                      
    MAX(CASE WHEN (dimscore.Dimension_ID = 21) then dimscore.Dimension_Score else null END) as dim21,
	MAX(CASE WHEN (dimscore.Dimension_ID = 22) then dimscore.Dimension_Score else null END) as dim22,
	MAX(CASE WHEN (dimscore.Dimension_ID = 23) then dimscore.Dimension_Score else null END) as dim23,
    MAX(CASE WHEN (dimscore.Dimension_ID = 24) then dimscore.Dimension_Score else null END) as dim24

    
                      
FROM         #fromview as xr left JOIN
                      Dimension_Scores as dimscore ON
                       (xr.aid = dimscore.Applicant_ID) and
                       (xr.testid = dimscore.Assessment_ID) and
                       (xr.s = dimscore.Session_ID) and
                       (xr.scorever = dimscore.Scoring_Version)
                       
WHERE     (xr.TestID = @Assessment_ID) AND (@Start_Date_From IS NULL OR
                      xr.SDate >= @Start_Date_From) AND (@Start_Date_To IS NULL OR
                      xr.SDate <= @Start_Date_To) AND (@Completion_Date_From IS NULL OR
                      xr.CDate >= @Completion_Date_From) AND (@Completion_Date_To IS NULL OR
                      xr.CDate <= @Completion_Date_To) AND
                      
		  ( 
		  ((@Status_Code1 is null) or (xr.SC = @Status_Code1)) and
		  ((@Status_Code2 is null) or (xr.SC = @Status_Code2))
		  )

group by
					  xr.aid, xr.TestID, xr.s, xr.r, xr.fn, 
                      xr.ln, xr.id, xr.emp, xr.id2, xr.SC, 
                      xr.SDate, xr.ASDate, xr.ActivDate, xr.CDate, 
                      xr.ttime, xr.qtime, xr.Score, xr.scorever, xr.cv, xr.lang, 
                      xr.altver, xr.d1, xr.d2, xr.d3, xr.d4, 
                      xr.d5, xr.d6, xr.d7, xr.d8, xr.d9, 
                      xr.d10, xr.d11, xr.d12, xr.d13, xr.d14, 
                      xr.d15, xr.d16, xr.d17, xr.d18, xr.d19, 
                      xr.d20, xr.d21, xr.d22, xr.d23, xr.d24, 
                      xr.d25, xr.d26, xr.d27, xr.d28, xr.d29, 
                      xr.d30, xr.d31, xr.d32
		 
for xml auto, elements XSINIL

drop table #fromview
GO
