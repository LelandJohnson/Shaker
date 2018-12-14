SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns applicant, applicant_sessions, and applicant_data columns about user+session 
--				and user answers (text ones)
--			    
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[export_applicant_measures_text]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint,	
	@cv float = 1,	--content version, known from the pre-export check to prevent cross-contentver feedback exports,
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

CREATE TABLE #measures
(
 [row] int,
 Measure_ID smallint,
 Content_Version real,
 Measure_Name varchar(50)
)

--DECLARE @measures TABLE --table var was not faster than temp table
--( 
-- [row] int,
-- Measure_ID smallint,
-- Content_Version real,
-- Measure_Name varchar(30)
--)




insert into #measures ([row], Measure_ID, Content_Version, Measure_Name)
SELECT    ROW_NUMBER() OVER (ORDER BY Measure_ID) AS row,
 Measure_ID, Content_Version, Measure_Name
FROM         dbo.Measures
WHERE     textual=1 and assessment_id=@Assessment_ID and Content_Version=@cv


	
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





 	
SELECT     
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
                      xr.d30, xr.d31, xr.d32,
                    
  MAX(CASE WHEN (m.row=1)  then meas_t.[Value]  else null END) as m1,
  MAX(CASE WHEN (m.row=2)  then meas_t.[Value]  else null END) as m2,
  MAX(CASE WHEN (m.row=3)  then meas_t.[Value]  else null END) as m3,
  MAX(CASE WHEN (m.row=4)  then meas_t.[Value]  else null END) as m4,
  MAX(CASE WHEN (m.row=5)  then meas_t.[Value]  else null END) as m5,
  MAX(CASE WHEN (m.row=6)  then meas_t.[Value]  else null END) as m6,
  MAX(CASE WHEN (m.row=7)  then meas_t.[Value]  else null END) as m7,
  MAX(CASE WHEN (m.row=8)  then meas_t.[Value]  else null END) as m8,
  MAX(CASE WHEN (m.row=9)  then meas_t.[Value]  else null END) as m9,
  MAX(CASE WHEN (m.row=10)  then meas_t.[Value]  else null END) as m10,
  MAX(CASE WHEN (m.row=11)  then meas_t.[Value]  else null END) as m11,
  MAX(CASE WHEN (m.row=12)  then meas_t.[Value]  else null END) as m12,
  MAX(CASE WHEN (m.row=13)  then meas_t.[Value]  else null END) as m13,
  MAX(CASE WHEN (m.row=14)  then meas_t.[Value]  else null END) as m14,
  MAX(CASE WHEN (m.row=15)  then meas_t.[Value]  else null END) as m15,
  MAX(CASE WHEN (m.row=16)  then meas_t.[Value]  else null END) as m16,
  MAX(CASE WHEN (m.row=17)  then meas_t.[Value]  else null END) as m17,
  MAX(CASE WHEN (m.row=18)  then meas_t.[Value]  else null END) as m18,
  MAX(CASE WHEN (m.row=19)  then meas_t.[Value]  else null END) as m19,
  MAX(CASE WHEN (m.row=20)  then meas_t.[Value]  else null END) as m20,
  MAX(CASE WHEN (m.row=21)  then meas_t.[Value]  else null END) as m21,
  MAX(CASE WHEN (m.row=22)  then meas_t.[Value]  else null END) as m22,
  MAX(CASE WHEN (m.row=23)  then meas_t.[Value]  else null END) as m23,
  MAX(CASE WHEN (m.row=24)  then meas_t.[Value]  else null END) as m24,
  MAX(CASE WHEN (m.row=25)  then meas_t.[Value]  else null END) as m25,
  MAX(CASE WHEN (m.row=26)  then meas_t.[Value]  else null END) as m26,
  MAX(CASE WHEN (m.row=27)  then meas_t.[Value]  else null END) as m27,
  MAX(CASE WHEN (m.row=28)  then meas_t.[Value]  else null END) as m28,
  MAX(CASE WHEN (m.row=29)  then meas_t.[Value]  else null END) as m29,
  MAX(CASE WHEN (m.row=30)  then meas_t.[Value]  else null END) as m30,
  MAX(CASE WHEN (m.row=31)  then meas_t.[Value]  else null END) as m31,
  MAX(CASE WHEN (m.row=32)  then meas_t.[Value]  else null END) as m32,
  MAX(CASE WHEN (m.row=33)  then meas_t.[Value]  else null END) as m33,
  MAX(CASE WHEN (m.row=34)  then meas_t.[Value]  else null END) as m34,
  MAX(CASE WHEN (m.row=35)  then meas_t.[Value]  else null END) as m35,
  MAX(CASE WHEN (m.row=36)  then meas_t.[Value]  else null END) as m36,
  MAX(CASE WHEN (m.row=37)  then meas_t.[Value]  else null END) as m37,
  MAX(CASE WHEN (m.row=38)  then meas_t.[Value]  else null END) as m38,
  MAX(CASE WHEN (m.row=39)  then meas_t.[Value]  else null END) as m39,
  MAX(CASE WHEN (m.row=40)  then meas_t.[Value]  else null END) as m40,
  MAX(CASE WHEN (m.row=41)  then meas_t.[Value]  else null END) as m41,
  MAX(CASE WHEN (m.row=42)  then meas_t.[Value]  else null END) as m42,
  MAX(CASE WHEN (m.row=43)  then meas_t.[Value]  else null END) as m43,
  MAX(CASE WHEN (m.row=44)  then meas_t.[Value]  else null END) as m44,
  MAX(CASE WHEN (m.row=45)  then meas_t.[Value]  else null END) as m45,
  MAX(CASE WHEN (m.row=46)  then meas_t.[Value]  else null END) as m46,
  MAX(CASE WHEN (m.row=47)  then meas_t.[Value]  else null END) as m47,
  MAX(CASE WHEN (m.row=48)  then meas_t.[Value]  else null END) as m48,
  MAX(CASE WHEN (m.row=49)  then meas_t.[Value]  else null END) as m49,
  MAX(CASE WHEN (m.row=50)  then meas_t.[Value]  else null END) as m50,
  MAX(CASE WHEN (m.row=51)  then meas_t.[Value]  else null END) as m51,
  MAX(CASE WHEN (m.row=52)  then meas_t.[Value]  else null END) as m52,
  MAX(CASE WHEN (m.row=53)  then meas_t.[Value]  else null END) as m53,
  MAX(CASE WHEN (m.row=54)  then meas_t.[Value]  else null END) as m54,
  MAX(CASE WHEN (m.row=55)  then meas_t.[Value]  else null END) as m55,
  MAX(CASE WHEN (m.row=56)  then meas_t.[Value]  else null END) as m56,
  MAX(CASE WHEN (m.row=57)  then meas_t.[Value]  else null END) as m57,
  MAX(CASE WHEN (m.row=58)  then meas_t.[Value]  else null END) as m58,
  MAX(CASE WHEN (m.row=59)  then meas_t.[Value]  else null END) as m59,
  MAX(CASE WHEN (m.row=60)  then meas_t.[Value]  else null END) as m60,
  MAX(CASE WHEN (m.row=61)  then meas_t.[Value]  else null END) as m61,
  MAX(CASE WHEN (m.row=62)  then meas_t.[Value]  else null END) as m62,
  MAX(CASE WHEN (m.row=63)  then meas_t.[Value]  else null END) as m63,
  MAX(CASE WHEN (m.row=64)  then meas_t.[Value]  else null END) as m64,
  MAX(CASE WHEN (m.row=65)  then meas_t.[Value]  else null END) as m65,
  MAX(CASE WHEN (m.row=66)  then meas_t.[Value]  else null END) as m66,
  MAX(CASE WHEN (m.row=67)  then meas_t.[Value]  else null END) as m67,
  MAX(CASE WHEN (m.row=68)  then meas_t.[Value]  else null END) as m68,
  MAX(CASE WHEN (m.row=69)  then meas_t.[Value]  else null END) as m69,
  MAX(CASE WHEN (m.row=70)  then meas_t.[Value]  else null END) as m70,
  MAX(CASE WHEN (m.row=71)  then meas_t.[Value]  else null END) as m71,
  MAX(CASE WHEN (m.row=72)  then meas_t.[Value]  else null END) as m72,
  MAX(CASE WHEN (m.row=73)  then meas_t.[Value]  else null END) as m73,
  MAX(CASE WHEN (m.row=74)  then meas_t.[Value]  else null END) as m74,
  MAX(CASE WHEN (m.row=75)  then meas_t.[Value]  else null END) as m75,
  MAX(CASE WHEN (m.row=76)  then meas_t.[Value]  else null END) as m76,
  MAX(CASE WHEN (m.row=77)  then meas_t.[Value]  else null END) as m77,
  MAX(CASE WHEN (m.row=78)  then meas_t.[Value]  else null END) as m78,
  MAX(CASE WHEN (m.row=79)  then meas_t.[Value]  else null END) as m79,
  MAX(CASE WHEN (m.row=80)  then meas_t.[Value]  else null END) as m80,
  MAX(CASE WHEN (m.row=81)  then meas_t.[Value]  else null END) as m81,
  MAX(CASE WHEN (m.row=82)  then meas_t.[Value]  else null END) as m82,
  MAX(CASE WHEN (m.row=83)  then meas_t.[Value]  else null END) as m83,
  MAX(CASE WHEN (m.row=84)  then meas_t.[Value]  else null END) as m84,
  MAX(CASE WHEN (m.row=85)  then meas_t.[Value]  else null END) as m85,
  MAX(CASE WHEN (m.row=86)  then meas_t.[Value]  else null END) as m86,
  MAX(CASE WHEN (m.row=87)  then meas_t.[Value]  else null END) as m87,
  MAX(CASE WHEN (m.row=88)  then meas_t.[Value]  else null END) as m88,
  MAX(CASE WHEN (m.row=89)  then meas_t.[Value]  else null END) as m89,
  MAX(CASE WHEN (m.row=90)  then meas_t.[Value]  else null END) as m90,
  MAX(CASE WHEN (m.row=91)  then meas_t.[Value]  else null END) as m91,
  MAX(CASE WHEN (m.row=92)  then meas_t.[Value]  else null END) as m92,
  MAX(CASE WHEN (m.row=93)  then meas_t.[Value]  else null END) as m93,
  MAX(CASE WHEN (m.row=94)  then meas_t.[Value]  else null END) as m94,
  MAX(CASE WHEN (m.row=95)  then meas_t.[Value]  else null END) as m95,
  MAX(CASE WHEN (m.row=96)  then meas_t.[Value]  else null END) as m96,
  MAX(CASE WHEN (m.row=97)  then meas_t.[Value]  else null END) as m97,
  MAX(CASE WHEN (m.row=98)  then meas_t.[Value]  else null END) as m98,
  MAX(CASE WHEN (m.row=99)  then meas_t.[Value]  else null END) as m99,
  MAX(CASE WHEN (m.row=100)  then meas_t.[Value]  else null END) as m100,
  MAX(CASE WHEN (m.row=101)  then meas_t.[Value]  else null END) as m101,
  MAX(CASE WHEN (m.row=102)  then meas_t.[Value]  else null END) as m102,
  MAX(CASE WHEN (m.row=103)  then meas_t.[Value]  else null END) as m103,
  MAX(CASE WHEN (m.row=104)  then meas_t.[Value]  else null END) as m104,
  MAX(CASE WHEN (m.row=105)  then meas_t.[Value]  else null END) as m105,
  MAX(CASE WHEN (m.row=106)  then meas_t.[Value]  else null END) as m106,
  MAX(CASE WHEN (m.row=107)  then meas_t.[Value]  else null END) as m107,
  MAX(CASE WHEN (m.row=108)  then meas_t.[Value]  else null END) as m108,
  MAX(CASE WHEN (m.row=109)  then meas_t.[Value]  else null END) as m109,
  MAX(CASE WHEN (m.row=110)  then meas_t.[Value]  else null END) as m110,
  MAX(CASE WHEN (m.row=111)  then meas_t.[Value]  else null END) as m111,
  MAX(CASE WHEN (m.row=112)  then meas_t.[Value]  else null END) as m112,
  MAX(CASE WHEN (m.row=113)  then meas_t.[Value]  else null END) as m113,
  MAX(CASE WHEN (m.row=114)  then meas_t.[Value]  else null END) as m114,
  MAX(CASE WHEN (m.row=115)  then meas_t.[Value]  else null END) as m115,
  MAX(CASE WHEN (m.row=116)  then meas_t.[Value]  else null END) as m116,
  MAX(CASE WHEN (m.row=117)  then meas_t.[Value]  else null END) as m117,
  MAX(CASE WHEN (m.row=118)  then meas_t.[Value]  else null END) as m118,
  MAX(CASE WHEN (m.row=119)  then meas_t.[Value]  else null END) as m119,
  MAX(CASE WHEN (m.row=120)  then meas_t.[Value]  else null END) as m120,
  MAX(CASE WHEN (m.row=121)  then meas_t.[Value]  else null END) as m121,
  MAX(CASE WHEN (m.row=122)  then meas_t.[Value]  else null END) as m122,
  MAX(CASE WHEN (m.row=123)  then meas_t.[Value]  else null END) as m123,
  MAX(CASE WHEN (m.row=124)  then meas_t.[Value]  else null END) as m124,
  MAX(CASE WHEN (m.row=125)  then meas_t.[Value]  else null END) as m125,
  MAX(CASE WHEN (m.row=126)  then meas_t.[Value]  else null END) as m126,
  MAX(CASE WHEN (m.row=127)  then meas_t.[Value]  else null END) as m127,
  MAX(CASE WHEN (m.row=128)  then meas_t.[Value]  else null END) as m128
      
                      
FROM         #fromview as xr left JOIN
                      Applicant_Measures_Text as meas_t ON
                       (xr.aid = meas_t.Applicant_ID) and
                       (xr.testid = meas_t.Assessment_ID) and
                       (xr.s = meas_t.Session_ID) left join
                        #measures as m
                         on m.Measure_ID = meas_t.Measure_ID
                         
						              
                       
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
drop table #measures
GO
