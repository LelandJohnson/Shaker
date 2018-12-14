SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns applicant, applicant_sessions, and applicant_data columns about user+session 
--				and user answers (numeric ones)
--			    
-- History:		v1
--				v2 increase max measures to 450
-- =============================================
CREATE PROCEDURE [dbo].[export_applicant_measures_num]
	
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
WHERE     textual=0 and assessment_id=@Assessment_ID and Content_Version=@cv


	
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
                    
  MAX(CASE WHEN (m.row=1)  then meas_n.[Value]  else null END) as m1,
  MAX(CASE WHEN (m.row=2)  then meas_n.[Value]  else null END) as m2,
  MAX(CASE WHEN (m.row=3)  then meas_n.[Value]  else null END) as m3,
  MAX(CASE WHEN (m.row=4)  then meas_n.[Value]  else null END) as m4,
  MAX(CASE WHEN (m.row=5)  then meas_n.[Value]  else null END) as m5,
  MAX(CASE WHEN (m.row=6)  then meas_n.[Value]  else null END) as m6,
  MAX(CASE WHEN (m.row=7)  then meas_n.[Value]  else null END) as m7,
  MAX(CASE WHEN (m.row=8)  then meas_n.[Value]  else null END) as m8,
  MAX(CASE WHEN (m.row=9)  then meas_n.[Value]  else null END) as m9,
  MAX(CASE WHEN (m.row=10)  then meas_n.[Value]  else null END) as m10,
  MAX(CASE WHEN (m.row=11)  then meas_n.[Value]  else null END) as m11,
  MAX(CASE WHEN (m.row=12)  then meas_n.[Value]  else null END) as m12,
  MAX(CASE WHEN (m.row=13)  then meas_n.[Value]  else null END) as m13,
  MAX(CASE WHEN (m.row=14)  then meas_n.[Value]  else null END) as m14,
  MAX(CASE WHEN (m.row=15)  then meas_n.[Value]  else null END) as m15,
  MAX(CASE WHEN (m.row=16)  then meas_n.[Value]  else null END) as m16,
  MAX(CASE WHEN (m.row=17)  then meas_n.[Value]  else null END) as m17,
  MAX(CASE WHEN (m.row=18)  then meas_n.[Value]  else null END) as m18,
  MAX(CASE WHEN (m.row=19)  then meas_n.[Value]  else null END) as m19,
  MAX(CASE WHEN (m.row=20)  then meas_n.[Value]  else null END) as m20,
  MAX(CASE WHEN (m.row=21)  then meas_n.[Value]  else null END) as m21,
  MAX(CASE WHEN (m.row=22)  then meas_n.[Value]  else null END) as m22,
  MAX(CASE WHEN (m.row=23)  then meas_n.[Value]  else null END) as m23,
  MAX(CASE WHEN (m.row=24)  then meas_n.[Value]  else null END) as m24,
  MAX(CASE WHEN (m.row=25)  then meas_n.[Value]  else null END) as m25,
  MAX(CASE WHEN (m.row=26)  then meas_n.[Value]  else null END) as m26,
  MAX(CASE WHEN (m.row=27)  then meas_n.[Value]  else null END) as m27,
  MAX(CASE WHEN (m.row=28)  then meas_n.[Value]  else null END) as m28,
  MAX(CASE WHEN (m.row=29)  then meas_n.[Value]  else null END) as m29,
  MAX(CASE WHEN (m.row=30)  then meas_n.[Value]  else null END) as m30,
  MAX(CASE WHEN (m.row=31)  then meas_n.[Value]  else null END) as m31,
  MAX(CASE WHEN (m.row=32)  then meas_n.[Value]  else null END) as m32,
  MAX(CASE WHEN (m.row=33)  then meas_n.[Value]  else null END) as m33,
  MAX(CASE WHEN (m.row=34)  then meas_n.[Value]  else null END) as m34,
  MAX(CASE WHEN (m.row=35)  then meas_n.[Value]  else null END) as m35,
  MAX(CASE WHEN (m.row=36)  then meas_n.[Value]  else null END) as m36,
  MAX(CASE WHEN (m.row=37)  then meas_n.[Value]  else null END) as m37,
  MAX(CASE WHEN (m.row=38)  then meas_n.[Value]  else null END) as m38,
  MAX(CASE WHEN (m.row=39)  then meas_n.[Value]  else null END) as m39,
  MAX(CASE WHEN (m.row=40)  then meas_n.[Value]  else null END) as m40,
  MAX(CASE WHEN (m.row=41)  then meas_n.[Value]  else null END) as m41,
  MAX(CASE WHEN (m.row=42)  then meas_n.[Value]  else null END) as m42,
  MAX(CASE WHEN (m.row=43)  then meas_n.[Value]  else null END) as m43,
  MAX(CASE WHEN (m.row=44)  then meas_n.[Value]  else null END) as m44,
  MAX(CASE WHEN (m.row=45)  then meas_n.[Value]  else null END) as m45,
  MAX(CASE WHEN (m.row=46)  then meas_n.[Value]  else null END) as m46,
  MAX(CASE WHEN (m.row=47)  then meas_n.[Value]  else null END) as m47,
  MAX(CASE WHEN (m.row=48)  then meas_n.[Value]  else null END) as m48,
  MAX(CASE WHEN (m.row=49)  then meas_n.[Value]  else null END) as m49,
  MAX(CASE WHEN (m.row=50)  then meas_n.[Value]  else null END) as m50,
  MAX(CASE WHEN (m.row=51)  then meas_n.[Value]  else null END) as m51,
  MAX(CASE WHEN (m.row=52)  then meas_n.[Value]  else null END) as m52,
  MAX(CASE WHEN (m.row=53)  then meas_n.[Value]  else null END) as m53,
  MAX(CASE WHEN (m.row=54)  then meas_n.[Value]  else null END) as m54,
  MAX(CASE WHEN (m.row=55)  then meas_n.[Value]  else null END) as m55,
  MAX(CASE WHEN (m.row=56)  then meas_n.[Value]  else null END) as m56,
  MAX(CASE WHEN (m.row=57)  then meas_n.[Value]  else null END) as m57,
  MAX(CASE WHEN (m.row=58)  then meas_n.[Value]  else null END) as m58,
  MAX(CASE WHEN (m.row=59)  then meas_n.[Value]  else null END) as m59,
  MAX(CASE WHEN (m.row=60)  then meas_n.[Value]  else null END) as m60,
  MAX(CASE WHEN (m.row=61)  then meas_n.[Value]  else null END) as m61,
  MAX(CASE WHEN (m.row=62)  then meas_n.[Value]  else null END) as m62,
  MAX(CASE WHEN (m.row=63)  then meas_n.[Value]  else null END) as m63,
  MAX(CASE WHEN (m.row=64)  then meas_n.[Value]  else null END) as m64,
  MAX(CASE WHEN (m.row=65)  then meas_n.[Value]  else null END) as m65,
  MAX(CASE WHEN (m.row=66)  then meas_n.[Value]  else null END) as m66,
  MAX(CASE WHEN (m.row=67)  then meas_n.[Value]  else null END) as m67,
  MAX(CASE WHEN (m.row=68)  then meas_n.[Value]  else null END) as m68,
  MAX(CASE WHEN (m.row=69)  then meas_n.[Value]  else null END) as m69,
  MAX(CASE WHEN (m.row=70)  then meas_n.[Value]  else null END) as m70,
  MAX(CASE WHEN (m.row=71)  then meas_n.[Value]  else null END) as m71,
  MAX(CASE WHEN (m.row=72)  then meas_n.[Value]  else null END) as m72,
  MAX(CASE WHEN (m.row=73)  then meas_n.[Value]  else null END) as m73,
  MAX(CASE WHEN (m.row=74)  then meas_n.[Value]  else null END) as m74,
  MAX(CASE WHEN (m.row=75)  then meas_n.[Value]  else null END) as m75,
  MAX(CASE WHEN (m.row=76)  then meas_n.[Value]  else null END) as m76,
  MAX(CASE WHEN (m.row=77)  then meas_n.[Value]  else null END) as m77,
  MAX(CASE WHEN (m.row=78)  then meas_n.[Value]  else null END) as m78,
  MAX(CASE WHEN (m.row=79)  then meas_n.[Value]  else null END) as m79,
  MAX(CASE WHEN (m.row=80)  then meas_n.[Value]  else null END) as m80,
  MAX(CASE WHEN (m.row=81)  then meas_n.[Value]  else null END) as m81,
  MAX(CASE WHEN (m.row=82)  then meas_n.[Value]  else null END) as m82,
  MAX(CASE WHEN (m.row=83)  then meas_n.[Value]  else null END) as m83,
  MAX(CASE WHEN (m.row=84)  then meas_n.[Value]  else null END) as m84,
  MAX(CASE WHEN (m.row=85)  then meas_n.[Value]  else null END) as m85,
  MAX(CASE WHEN (m.row=86)  then meas_n.[Value]  else null END) as m86,
  MAX(CASE WHEN (m.row=87)  then meas_n.[Value]  else null END) as m87,
  MAX(CASE WHEN (m.row=88)  then meas_n.[Value]  else null END) as m88,
  MAX(CASE WHEN (m.row=89)  then meas_n.[Value]  else null END) as m89,
  MAX(CASE WHEN (m.row=90)  then meas_n.[Value]  else null END) as m90,
  MAX(CASE WHEN (m.row=91)  then meas_n.[Value]  else null END) as m91,
  MAX(CASE WHEN (m.row=92)  then meas_n.[Value]  else null END) as m92,
  MAX(CASE WHEN (m.row=93)  then meas_n.[Value]  else null END) as m93,
  MAX(CASE WHEN (m.row=94)  then meas_n.[Value]  else null END) as m94,
  MAX(CASE WHEN (m.row=95)  then meas_n.[Value]  else null END) as m95,
  MAX(CASE WHEN (m.row=96)  then meas_n.[Value]  else null END) as m96,
  MAX(CASE WHEN (m.row=97)  then meas_n.[Value]  else null END) as m97,
  MAX(CASE WHEN (m.row=98)  then meas_n.[Value]  else null END) as m98,
  MAX(CASE WHEN (m.row=99)  then meas_n.[Value]  else null END) as m99,
  MAX(CASE WHEN (m.row=100)  then meas_n.[Value]  else null END) as m100,
  MAX(CASE WHEN (m.row=101)  then meas_n.[Value]  else null END) as m101,
  MAX(CASE WHEN (m.row=102)  then meas_n.[Value]  else null END) as m102,
  MAX(CASE WHEN (m.row=103)  then meas_n.[Value]  else null END) as m103,
  MAX(CASE WHEN (m.row=104)  then meas_n.[Value]  else null END) as m104,
  MAX(CASE WHEN (m.row=105)  then meas_n.[Value]  else null END) as m105,
  MAX(CASE WHEN (m.row=106)  then meas_n.[Value]  else null END) as m106,
  MAX(CASE WHEN (m.row=107)  then meas_n.[Value]  else null END) as m107,
  MAX(CASE WHEN (m.row=108)  then meas_n.[Value]  else null END) as m108,
  MAX(CASE WHEN (m.row=109)  then meas_n.[Value]  else null END) as m109,
  MAX(CASE WHEN (m.row=110)  then meas_n.[Value]  else null END) as m110,
  MAX(CASE WHEN (m.row=111)  then meas_n.[Value]  else null END) as m111,
  MAX(CASE WHEN (m.row=112)  then meas_n.[Value]  else null END) as m112,
  MAX(CASE WHEN (m.row=113)  then meas_n.[Value]  else null END) as m113,
  MAX(CASE WHEN (m.row=114)  then meas_n.[Value]  else null END) as m114,
  MAX(CASE WHEN (m.row=115)  then meas_n.[Value]  else null END) as m115,
  MAX(CASE WHEN (m.row=116)  then meas_n.[Value]  else null END) as m116,
  MAX(CASE WHEN (m.row=117)  then meas_n.[Value]  else null END) as m117,
  MAX(CASE WHEN (m.row=118)  then meas_n.[Value]  else null END) as m118,
  MAX(CASE WHEN (m.row=119)  then meas_n.[Value]  else null END) as m119,
  MAX(CASE WHEN (m.row=120)  then meas_n.[Value]  else null END) as m120,
  MAX(CASE WHEN (m.row=121)  then meas_n.[Value]  else null END) as m121,
  MAX(CASE WHEN (m.row=122)  then meas_n.[Value]  else null END) as m122,
  MAX(CASE WHEN (m.row=123)  then meas_n.[Value]  else null END) as m123,
  MAX(CASE WHEN (m.row=124)  then meas_n.[Value]  else null END) as m124,
  MAX(CASE WHEN (m.row=125)  then meas_n.[Value]  else null END) as m125,
  MAX(CASE WHEN (m.row=126)  then meas_n.[Value]  else null END) as m126,
  MAX(CASE WHEN (m.row=127)  then meas_n.[Value]  else null END) as m127,
  MAX(CASE WHEN (m.row=128)  then meas_n.[Value]  else null END) as m128,
  MAX(CASE WHEN (m.row=129)  then meas_n.[Value]  else null END) as m129,
  MAX(CASE WHEN (m.row=130)  then meas_n.[Value]  else null END) as m130,
  MAX(CASE WHEN (m.row=131)  then meas_n.[Value]  else null END) as m131,
  MAX(CASE WHEN (m.row=132)  then meas_n.[Value]  else null END) as m132,
  MAX(CASE WHEN (m.row=133)  then meas_n.[Value]  else null END) as m133,
  MAX(CASE WHEN (m.row=134)  then meas_n.[Value]  else null END) as m134,
  MAX(CASE WHEN (m.row=135)  then meas_n.[Value]  else null END) as m135,
  MAX(CASE WHEN (m.row=136)  then meas_n.[Value]  else null END) as m136,
  MAX(CASE WHEN (m.row=137)  then meas_n.[Value]  else null END) as m137,
  MAX(CASE WHEN (m.row=138)  then meas_n.[Value]  else null END) as m138,
  MAX(CASE WHEN (m.row=139)  then meas_n.[Value]  else null END) as m139,
  MAX(CASE WHEN (m.row=140)  then meas_n.[Value]  else null END) as m140,
  MAX(CASE WHEN (m.row=141)  then meas_n.[Value]  else null END) as m141,
  MAX(CASE WHEN (m.row=142)  then meas_n.[Value]  else null END) as m142,
  MAX(CASE WHEN (m.row=143)  then meas_n.[Value]  else null END) as m143,
  MAX(CASE WHEN (m.row=144)  then meas_n.[Value]  else null END) as m144,
  MAX(CASE WHEN (m.row=145)  then meas_n.[Value]  else null END) as m145,
  MAX(CASE WHEN (m.row=146)  then meas_n.[Value]  else null END) as m146,
  MAX(CASE WHEN (m.row=147)  then meas_n.[Value]  else null END) as m147,
  MAX(CASE WHEN (m.row=148)  then meas_n.[Value]  else null END) as m148,
  MAX(CASE WHEN (m.row=149)  then meas_n.[Value]  else null END) as m149,
  MAX(CASE WHEN (m.row=150)  then meas_n.[Value]  else null END) as m150,
  MAX(CASE WHEN (m.row=151)  then meas_n.[Value]  else null END) as m151,
  MAX(CASE WHEN (m.row=152)  then meas_n.[Value]  else null END) as m152,
  MAX(CASE WHEN (m.row=153)  then meas_n.[Value]  else null END) as m153,
  MAX(CASE WHEN (m.row=154)  then meas_n.[Value]  else null END) as m154,
  MAX(CASE WHEN (m.row=155)  then meas_n.[Value]  else null END) as m155,
  MAX(CASE WHEN (m.row=156)  then meas_n.[Value]  else null END) as m156,
  MAX(CASE WHEN (m.row=157)  then meas_n.[Value]  else null END) as m157,
  MAX(CASE WHEN (m.row=158)  then meas_n.[Value]  else null END) as m158,
  MAX(CASE WHEN (m.row=159)  then meas_n.[Value]  else null END) as m159,
  MAX(CASE WHEN (m.row=160)  then meas_n.[Value]  else null END) as m160,
  MAX(CASE WHEN (m.row=161)  then meas_n.[Value]  else null END) as m161,
  MAX(CASE WHEN (m.row=162)  then meas_n.[Value]  else null END) as m162,
  MAX(CASE WHEN (m.row=163)  then meas_n.[Value]  else null END) as m163,
  MAX(CASE WHEN (m.row=164)  then meas_n.[Value]  else null END) as m164,
  MAX(CASE WHEN (m.row=165)  then meas_n.[Value]  else null END) as m165,
  MAX(CASE WHEN (m.row=166)  then meas_n.[Value]  else null END) as m166,
  MAX(CASE WHEN (m.row=167)  then meas_n.[Value]  else null END) as m167,
  MAX(CASE WHEN (m.row=168)  then meas_n.[Value]  else null END) as m168,
  MAX(CASE WHEN (m.row=169)  then meas_n.[Value]  else null END) as m169,
  MAX(CASE WHEN (m.row=170)  then meas_n.[Value]  else null END) as m170,
  MAX(CASE WHEN (m.row=171)  then meas_n.[Value]  else null END) as m171,
  MAX(CASE WHEN (m.row=172)  then meas_n.[Value]  else null END) as m172,
  MAX(CASE WHEN (m.row=173)  then meas_n.[Value]  else null END) as m173,
  MAX(CASE WHEN (m.row=174)  then meas_n.[Value]  else null END) as m174,
  MAX(CASE WHEN (m.row=175)  then meas_n.[Value]  else null END) as m175,
  MAX(CASE WHEN (m.row=176)  then meas_n.[Value]  else null END) as m176,
  MAX(CASE WHEN (m.row=177)  then meas_n.[Value]  else null END) as m177,
  MAX(CASE WHEN (m.row=178)  then meas_n.[Value]  else null END) as m178,
  MAX(CASE WHEN (m.row=179)  then meas_n.[Value]  else null END) as m179,
  MAX(CASE WHEN (m.row=180)  then meas_n.[Value]  else null END) as m180,
  MAX(CASE WHEN (m.row=181)  then meas_n.[Value]  else null END) as m181,
  MAX(CASE WHEN (m.row=182)  then meas_n.[Value]  else null END) as m182,
  MAX(CASE WHEN (m.row=183)  then meas_n.[Value]  else null END) as m183,
  MAX(CASE WHEN (m.row=184)  then meas_n.[Value]  else null END) as m184,
  MAX(CASE WHEN (m.row=185)  then meas_n.[Value]  else null END) as m185,
  MAX(CASE WHEN (m.row=186)  then meas_n.[Value]  else null END) as m186,
  MAX(CASE WHEN (m.row=187)  then meas_n.[Value]  else null END) as m187,
  MAX(CASE WHEN (m.row=188)  then meas_n.[Value]  else null END) as m188,
  MAX(CASE WHEN (m.row=189)  then meas_n.[Value]  else null END) as m189,
  MAX(CASE WHEN (m.row=190)  then meas_n.[Value]  else null END) as m190,
  MAX(CASE WHEN (m.row=191)  then meas_n.[Value]  else null END) as m191,
  MAX(CASE WHEN (m.row=192)  then meas_n.[Value]  else null END) as m192,
  MAX(CASE WHEN (m.row=193)  then meas_n.[Value]  else null END) as m193,
  MAX(CASE WHEN (m.row=194)  then meas_n.[Value]  else null END) as m194,
  MAX(CASE WHEN (m.row=195)  then meas_n.[Value]  else null END) as m195,
  MAX(CASE WHEN (m.row=196)  then meas_n.[Value]  else null END) as m196,
  MAX(CASE WHEN (m.row=197)  then meas_n.[Value]  else null END) as m197,
  MAX(CASE WHEN (m.row=198)  then meas_n.[Value]  else null END) as m198,
  MAX(CASE WHEN (m.row=199)  then meas_n.[Value]  else null END) as m199,
  MAX(CASE WHEN (m.row=200)  then meas_n.[Value]  else null END) as m200,
  MAX(CASE WHEN (m.row=201)  then meas_n.[Value]  else null END) as m201,
  MAX(CASE WHEN (m.row=202)  then meas_n.[Value]  else null END) as m202,
  MAX(CASE WHEN (m.row=203)  then meas_n.[Value]  else null END) as m203,
  MAX(CASE WHEN (m.row=204)  then meas_n.[Value]  else null END) as m204,
  MAX(CASE WHEN (m.row=205)  then meas_n.[Value]  else null END) as m205,
  MAX(CASE WHEN (m.row=206)  then meas_n.[Value]  else null END) as m206,
  MAX(CASE WHEN (m.row=207)  then meas_n.[Value]  else null END) as m207,
  MAX(CASE WHEN (m.row=208)  then meas_n.[Value]  else null END) as m208,
  MAX(CASE WHEN (m.row=209)  then meas_n.[Value]  else null END) as m209,
  MAX(CASE WHEN (m.row=210)  then meas_n.[Value]  else null END) as m210,
  MAX(CASE WHEN (m.row=211)  then meas_n.[Value]  else null END) as m211,
  MAX(CASE WHEN (m.row=212)  then meas_n.[Value]  else null END) as m212,
  MAX(CASE WHEN (m.row=213)  then meas_n.[Value]  else null END) as m213,
  MAX(CASE WHEN (m.row=214)  then meas_n.[Value]  else null END) as m214,
  MAX(CASE WHEN (m.row=215)  then meas_n.[Value]  else null END) as m215,
  MAX(CASE WHEN (m.row=216)  then meas_n.[Value]  else null END) as m216,
  MAX(CASE WHEN (m.row=217)  then meas_n.[Value]  else null END) as m217,
  MAX(CASE WHEN (m.row=218)  then meas_n.[Value]  else null END) as m218,
  MAX(CASE WHEN (m.row=219)  then meas_n.[Value]  else null END) as m219,
  MAX(CASE WHEN (m.row=220)  then meas_n.[Value]  else null END) as m220,
  MAX(CASE WHEN (m.row=221)  then meas_n.[Value]  else null END) as m221,
  MAX(CASE WHEN (m.row=222)  then meas_n.[Value]  else null END) as m222,
  MAX(CASE WHEN (m.row=223)  then meas_n.[Value]  else null END) as m223,
  MAX(CASE WHEN (m.row=224)  then meas_n.[Value]  else null END) as m224,
  MAX(CASE WHEN (m.row=225)  then meas_n.[Value]  else null END) as m225,
  MAX(CASE WHEN (m.row=226)  then meas_n.[Value]  else null END) as m226,
  MAX(CASE WHEN (m.row=227)  then meas_n.[Value]  else null END) as m227,
  MAX(CASE WHEN (m.row=228)  then meas_n.[Value]  else null END) as m228,
  MAX(CASE WHEN (m.row=229)  then meas_n.[Value]  else null END) as m229,
  MAX(CASE WHEN (m.row=230)  then meas_n.[Value]  else null END) as m230,
  MAX(CASE WHEN (m.row=231)  then meas_n.[Value]  else null END) as m231,
  MAX(CASE WHEN (m.row=232)  then meas_n.[Value]  else null END) as m232,
  MAX(CASE WHEN (m.row=233)  then meas_n.[Value]  else null END) as m233,
  MAX(CASE WHEN (m.row=234)  then meas_n.[Value]  else null END) as m234,
  MAX(CASE WHEN (m.row=235)  then meas_n.[Value]  else null END) as m235,
  MAX(CASE WHEN (m.row=236)  then meas_n.[Value]  else null END) as m236,
  MAX(CASE WHEN (m.row=237)  then meas_n.[Value]  else null END) as m237,
  MAX(CASE WHEN (m.row=238)  then meas_n.[Value]  else null END) as m238,
  MAX(CASE WHEN (m.row=239)  then meas_n.[Value]  else null END) as m239,
  MAX(CASE WHEN (m.row=240)  then meas_n.[Value]  else null END) as m240,
  MAX(CASE WHEN (m.row=241)  then meas_n.[Value]  else null END) as m241,
  MAX(CASE WHEN (m.row=242)  then meas_n.[Value]  else null END) as m242,
  MAX(CASE WHEN (m.row=243)  then meas_n.[Value]  else null END) as m243,
  MAX(CASE WHEN (m.row=244)  then meas_n.[Value]  else null END) as m244,
  MAX(CASE WHEN (m.row=245)  then meas_n.[Value]  else null END) as m245,
  MAX(CASE WHEN (m.row=246)  then meas_n.[Value]  else null END) as m246,
  MAX(CASE WHEN (m.row=247)  then meas_n.[Value]  else null END) as m247,
  MAX(CASE WHEN (m.row=248)  then meas_n.[Value]  else null END) as m248,
  MAX(CASE WHEN (m.row=249)  then meas_n.[Value]  else null END) as m249,
  MAX(CASE WHEN (m.row=250)  then meas_n.[Value]  else null END) as m250,
  MAX(CASE WHEN (m.row=251)  then meas_n.[Value]  else null END) as m251,
  MAX(CASE WHEN (m.row=252)  then meas_n.[Value]  else null END) as m252,
  MAX(CASE WHEN (m.row=253)  then meas_n.[Value]  else null END) as m253,
  MAX(CASE WHEN (m.row=254)  then meas_n.[Value]  else null END) as m254,
  MAX(CASE WHEN (m.row=255)  then meas_n.[Value]  else null END) as m255,
  MAX(CASE WHEN (m.row=256)  then meas_n.[Value]  else null END) as m256,
  MAX(CASE WHEN (m.row=257)  then meas_n.[Value]  else null END) as m257,
  MAX(CASE WHEN (m.row=258)  then meas_n.[Value]  else null END) as m258,
  MAX(CASE WHEN (m.row=259)  then meas_n.[Value]  else null END) as m259,
  MAX(CASE WHEN (m.row=260)  then meas_n.[Value]  else null END) as m260,
  MAX(CASE WHEN (m.row=261)  then meas_n.[Value]  else null END) as m261,
  MAX(CASE WHEN (m.row=262)  then meas_n.[Value]  else null END) as m262,
  MAX(CASE WHEN (m.row=263)  then meas_n.[Value]  else null END) as m263,
  MAX(CASE WHEN (m.row=264)  then meas_n.[Value]  else null END) as m264,
  MAX(CASE WHEN (m.row=265)  then meas_n.[Value]  else null END) as m265,
  MAX(CASE WHEN (m.row=266)  then meas_n.[Value]  else null END) as m266,
  MAX(CASE WHEN (m.row=267)  then meas_n.[Value]  else null END) as m267,
  MAX(CASE WHEN (m.row=268)  then meas_n.[Value]  else null END) as m268,
  MAX(CASE WHEN (m.row=269)  then meas_n.[Value]  else null END) as m269,
  MAX(CASE WHEN (m.row=270)  then meas_n.[Value]  else null END) as m270,
  MAX(CASE WHEN (m.row=271)  then meas_n.[Value]  else null END) as m271,
  MAX(CASE WHEN (m.row=272)  then meas_n.[Value]  else null END) as m272,
  MAX(CASE WHEN (m.row=273)  then meas_n.[Value]  else null END) as m273,
  MAX(CASE WHEN (m.row=274)  then meas_n.[Value]  else null END) as m274,
  MAX(CASE WHEN (m.row=275)  then meas_n.[Value]  else null END) as m275,
  MAX(CASE WHEN (m.row=276)  then meas_n.[Value]  else null END) as m276,
  MAX(CASE WHEN (m.row=277)  then meas_n.[Value]  else null END) as m277,
  MAX(CASE WHEN (m.row=278)  then meas_n.[Value]  else null END) as m278,
  MAX(CASE WHEN (m.row=279)  then meas_n.[Value]  else null END) as m279,
  MAX(CASE WHEN (m.row=280)  then meas_n.[Value]  else null END) as m280,
  MAX(CASE WHEN (m.row=281)  then meas_n.[Value]  else null END) as m281,
  MAX(CASE WHEN (m.row=282)  then meas_n.[Value]  else null END) as m282,
  MAX(CASE WHEN (m.row=283)  then meas_n.[Value]  else null END) as m283,
  MAX(CASE WHEN (m.row=284)  then meas_n.[Value]  else null END) as m284,
  MAX(CASE WHEN (m.row=285)  then meas_n.[Value]  else null END) as m285,
  MAX(CASE WHEN (m.row=286)  then meas_n.[Value]  else null END) as m286,
  MAX(CASE WHEN (m.row=287)  then meas_n.[Value]  else null END) as m287,
  MAX(CASE WHEN (m.row=288)  then meas_n.[Value]  else null END) as m288,
  MAX(CASE WHEN (m.row=289)  then meas_n.[Value]  else null END) as m289,
  MAX(CASE WHEN (m.row=290)  then meas_n.[Value]  else null END) as m290,
  MAX(CASE WHEN (m.row=291)  then meas_n.[Value]  else null END) as m291,
  MAX(CASE WHEN (m.row=292)  then meas_n.[Value]  else null END) as m292,
  MAX(CASE WHEN (m.row=293)  then meas_n.[Value]  else null END) as m293,
  MAX(CASE WHEN (m.row=294)  then meas_n.[Value]  else null END) as m294,
  MAX(CASE WHEN (m.row=295)  then meas_n.[Value]  else null END) as m295,
  MAX(CASE WHEN (m.row=296)  then meas_n.[Value]  else null END) as m296,
  MAX(CASE WHEN (m.row=297)  then meas_n.[Value]  else null END) as m297,
  MAX(CASE WHEN (m.row=298)  then meas_n.[Value]  else null END) as m298,
  MAX(CASE WHEN (m.row=299)  then meas_n.[Value]  else null END) as m299,
  MAX(CASE WHEN (m.row=300)  then meas_n.[Value]  else null END) as m300,
  MAX(CASE WHEN (m.row=301)  then meas_n.[Value]  else null END) as m301,
  MAX(CASE WHEN (m.row=302)  then meas_n.[Value]  else null END) as m302,
  MAX(CASE WHEN (m.row=303)  then meas_n.[Value]  else null END) as m303,
  MAX(CASE WHEN (m.row=304)  then meas_n.[Value]  else null END) as m304,
  MAX(CASE WHEN (m.row=305)  then meas_n.[Value]  else null END) as m305,
  MAX(CASE WHEN (m.row=306)  then meas_n.[Value]  else null END) as m306,
  MAX(CASE WHEN (m.row=307)  then meas_n.[Value]  else null END) as m307,
  MAX(CASE WHEN (m.row=308)  then meas_n.[Value]  else null END) as m308,
  MAX(CASE WHEN (m.row=309)  then meas_n.[Value]  else null END) as m309,
  MAX(CASE WHEN (m.row=310)  then meas_n.[Value]  else null END) as m310,
  MAX(CASE WHEN (m.row=311)  then meas_n.[Value]  else null END) as m311,
  MAX(CASE WHEN (m.row=312)  then meas_n.[Value]  else null END) as m312,
  MAX(CASE WHEN (m.row=313)  then meas_n.[Value]  else null END) as m313,
  MAX(CASE WHEN (m.row=314)  then meas_n.[Value]  else null END) as m314,
  MAX(CASE WHEN (m.row=315)  then meas_n.[Value]  else null END) as m315,
  MAX(CASE WHEN (m.row=316)  then meas_n.[Value]  else null END) as m316,
  MAX(CASE WHEN (m.row=317)  then meas_n.[Value]  else null END) as m317,
  MAX(CASE WHEN (m.row=318)  then meas_n.[Value]  else null END) as m318,
  MAX(CASE WHEN (m.row=319)  then meas_n.[Value]  else null END) as m319,
  MAX(CASE WHEN (m.row=320)  then meas_n.[Value]  else null END) as m320,
  MAX(CASE WHEN (m.row=321)  then meas_n.[Value]  else null END) as m321,
  MAX(CASE WHEN (m.row=322)  then meas_n.[Value]  else null END) as m322,
  MAX(CASE WHEN (m.row=323)  then meas_n.[Value]  else null END) as m323,
  MAX(CASE WHEN (m.row=324)  then meas_n.[Value]  else null END) as m324,
  MAX(CASE WHEN (m.row=325)  then meas_n.[Value]  else null END) as m325,
  MAX(CASE WHEN (m.row=326)  then meas_n.[Value]  else null END) as m326,
  MAX(CASE WHEN (m.row=327)  then meas_n.[Value]  else null END) as m327,
  MAX(CASE WHEN (m.row=328)  then meas_n.[Value]  else null END) as m328,
  MAX(CASE WHEN (m.row=329)  then meas_n.[Value]  else null END) as m329,
  MAX(CASE WHEN (m.row=330)  then meas_n.[Value]  else null END) as m330,
  MAX(CASE WHEN (m.row=331)  then meas_n.[Value]  else null END) as m331,
  MAX(CASE WHEN (m.row=332)  then meas_n.[Value]  else null END) as m332,
  MAX(CASE WHEN (m.row=333)  then meas_n.[Value]  else null END) as m333,
  MAX(CASE WHEN (m.row=334)  then meas_n.[Value]  else null END) as m334,
  MAX(CASE WHEN (m.row=335)  then meas_n.[Value]  else null END) as m335,
  MAX(CASE WHEN (m.row=336)  then meas_n.[Value]  else null END) as m336,
  MAX(CASE WHEN (m.row=337)  then meas_n.[Value]  else null END) as m337,
  MAX(CASE WHEN (m.row=338)  then meas_n.[Value]  else null END) as m338,
  MAX(CASE WHEN (m.row=339)  then meas_n.[Value]  else null END) as m339,
  MAX(CASE WHEN (m.row=340)  then meas_n.[Value]  else null END) as m340,
  MAX(CASE WHEN (m.row=341)  then meas_n.[Value]  else null END) as m341,
  MAX(CASE WHEN (m.row=342)  then meas_n.[Value]  else null END) as m342,
  MAX(CASE WHEN (m.row=343)  then meas_n.[Value]  else null END) as m343,
  MAX(CASE WHEN (m.row=344)  then meas_n.[Value]  else null END) as m344,
  MAX(CASE WHEN (m.row=345)  then meas_n.[Value]  else null END) as m345,
  MAX(CASE WHEN (m.row=346)  then meas_n.[Value]  else null END) as m346,
  MAX(CASE WHEN (m.row=347)  then meas_n.[Value]  else null END) as m347,
  MAX(CASE WHEN (m.row=348)  then meas_n.[Value]  else null END) as m348,
  MAX(CASE WHEN (m.row=349)  then meas_n.[Value]  else null END) as m349,
  MAX(CASE WHEN (m.row=350)  then meas_n.[Value]  else null END) as m350,
  MAX(CASE WHEN (m.row=351)  then meas_n.[Value]  else null END) as m351,
  MAX(CASE WHEN (m.row=352)  then meas_n.[Value]  else null END) as m352,
  MAX(CASE WHEN (m.row=353)  then meas_n.[Value]  else null END) as m353,
  MAX(CASE WHEN (m.row=354)  then meas_n.[Value]  else null END) as m354,
  MAX(CASE WHEN (m.row=355)  then meas_n.[Value]  else null END) as m355,
  MAX(CASE WHEN (m.row=356)  then meas_n.[Value]  else null END) as m356,
  MAX(CASE WHEN (m.row=357)  then meas_n.[Value]  else null END) as m357,
  MAX(CASE WHEN (m.row=358)  then meas_n.[Value]  else null END) as m358,
  MAX(CASE WHEN (m.row=359)  then meas_n.[Value]  else null END) as m359,
  MAX(CASE WHEN (m.row=360)  then meas_n.[Value]  else null END) as m360,
  MAX(CASE WHEN (m.row=361)  then meas_n.[Value]  else null END) as m361,
  MAX(CASE WHEN (m.row=362)  then meas_n.[Value]  else null END) as m362,
  MAX(CASE WHEN (m.row=363)  then meas_n.[Value]  else null END) as m363,
  MAX(CASE WHEN (m.row=364)  then meas_n.[Value]  else null END) as m364,
  MAX(CASE WHEN (m.row=365)  then meas_n.[Value]  else null END) as m365,
  MAX(CASE WHEN (m.row=366)  then meas_n.[Value]  else null END) as m366,
  MAX(CASE WHEN (m.row=367)  then meas_n.[Value]  else null END) as m367,
  MAX(CASE WHEN (m.row=368)  then meas_n.[Value]  else null END) as m368,
  MAX(CASE WHEN (m.row=369)  then meas_n.[Value]  else null END) as m369,
  MAX(CASE WHEN (m.row=370)  then meas_n.[Value]  else null END) as m370,
  MAX(CASE WHEN (m.row=371)  then meas_n.[Value]  else null END) as m371,
  MAX(CASE WHEN (m.row=372)  then meas_n.[Value]  else null END) as m372,
  MAX(CASE WHEN (m.row=373)  then meas_n.[Value]  else null END) as m373,
  MAX(CASE WHEN (m.row=374)  then meas_n.[Value]  else null END) as m374,
  MAX(CASE WHEN (m.row=375)  then meas_n.[Value]  else null END) as m375,
  MAX(CASE WHEN (m.row=376)  then meas_n.[Value]  else null END) as m376,
  MAX(CASE WHEN (m.row=377)  then meas_n.[Value]  else null END) as m377,
  MAX(CASE WHEN (m.row=378)  then meas_n.[Value]  else null END) as m378,
  MAX(CASE WHEN (m.row=379)  then meas_n.[Value]  else null END) as m379,
  MAX(CASE WHEN (m.row=380)  then meas_n.[Value]  else null END) as m380,
  MAX(CASE WHEN (m.row=381)  then meas_n.[Value]  else null END) as m381,
  MAX(CASE WHEN (m.row=382)  then meas_n.[Value]  else null END) as m382,
  MAX(CASE WHEN (m.row=383)  then meas_n.[Value]  else null END) as m383,
  MAX(CASE WHEN (m.row=384)  then meas_n.[Value]  else null END) as m384,
  MAX(CASE WHEN (m.row=385)  then meas_n.[Value]  else null END) as m385,
  MAX(CASE WHEN (m.row=386)  then meas_n.[Value]  else null END) as m386,
  MAX(CASE WHEN (m.row=387)  then meas_n.[Value]  else null END) as m387,
  MAX(CASE WHEN (m.row=388)  then meas_n.[Value]  else null END) as m388,
  MAX(CASE WHEN (m.row=389)  then meas_n.[Value]  else null END) as m389,
  MAX(CASE WHEN (m.row=390)  then meas_n.[Value]  else null END) as m390,
  MAX(CASE WHEN (m.row=391)  then meas_n.[Value]  else null END) as m391,
  MAX(CASE WHEN (m.row=392)  then meas_n.[Value]  else null END) as m392,
  MAX(CASE WHEN (m.row=393)  then meas_n.[Value]  else null END) as m393,
  MAX(CASE WHEN (m.row=394)  then meas_n.[Value]  else null END) as m394,
  MAX(CASE WHEN (m.row=395)  then meas_n.[Value]  else null END) as m395,
  MAX(CASE WHEN (m.row=396)  then meas_n.[Value]  else null END) as m396,
  MAX(CASE WHEN (m.row=397)  then meas_n.[Value]  else null END) as m397,
  MAX(CASE WHEN (m.row=398)  then meas_n.[Value]  else null END) as m398,
  MAX(CASE WHEN (m.row=399)  then meas_n.[Value]  else null END) as m399,
  MAX(CASE WHEN (m.row=400)  then meas_n.[Value]  else null END) as m400,
  MAX(CASE WHEN (m.row=401)  then meas_n.[Value]  else null END) as m401,
  MAX(CASE WHEN (m.row=402)  then meas_n.[Value]  else null END) as m402,
  MAX(CASE WHEN (m.row=403)  then meas_n.[Value]  else null END) as m403,
  MAX(CASE WHEN (m.row=404)  then meas_n.[Value]  else null END) as m404,
  MAX(CASE WHEN (m.row=405)  then meas_n.[Value]  else null END) as m405,
  MAX(CASE WHEN (m.row=406)  then meas_n.[Value]  else null END) as m406,
  MAX(CASE WHEN (m.row=407)  then meas_n.[Value]  else null END) as m407,
  MAX(CASE WHEN (m.row=408)  then meas_n.[Value]  else null END) as m408,
  MAX(CASE WHEN (m.row=409)  then meas_n.[Value]  else null END) as m409,
  MAX(CASE WHEN (m.row=410)  then meas_n.[Value]  else null END) as m410,
  MAX(CASE WHEN (m.row=411)  then meas_n.[Value]  else null END) as m411,
  MAX(CASE WHEN (m.row=412)  then meas_n.[Value]  else null END) as m412,
  MAX(CASE WHEN (m.row=413)  then meas_n.[Value]  else null END) as m413,
  MAX(CASE WHEN (m.row=414)  then meas_n.[Value]  else null END) as m414,
  MAX(CASE WHEN (m.row=415)  then meas_n.[Value]  else null END) as m415,
  MAX(CASE WHEN (m.row=416)  then meas_n.[Value]  else null END) as m416,
  MAX(CASE WHEN (m.row=417)  then meas_n.[Value]  else null END) as m417,
  MAX(CASE WHEN (m.row=418)  then meas_n.[Value]  else null END) as m418,
  MAX(CASE WHEN (m.row=419)  then meas_n.[Value]  else null END) as m419,
  MAX(CASE WHEN (m.row=420)  then meas_n.[Value]  else null END) as m420,
  MAX(CASE WHEN (m.row=421)  then meas_n.[Value]  else null END) as m421,
  MAX(CASE WHEN (m.row=422)  then meas_n.[Value]  else null END) as m422,
  MAX(CASE WHEN (m.row=423)  then meas_n.[Value]  else null END) as m423,
  MAX(CASE WHEN (m.row=424)  then meas_n.[Value]  else null END) as m424,
  MAX(CASE WHEN (m.row=425)  then meas_n.[Value]  else null END) as m425,
  MAX(CASE WHEN (m.row=426)  then meas_n.[Value]  else null END) as m426,
  MAX(CASE WHEN (m.row=427)  then meas_n.[Value]  else null END) as m427,
  MAX(CASE WHEN (m.row=428)  then meas_n.[Value]  else null END) as m428,
  MAX(CASE WHEN (m.row=429)  then meas_n.[Value]  else null END) as m429,
  MAX(CASE WHEN (m.row=430)  then meas_n.[Value]  else null END) as m430,
  MAX(CASE WHEN (m.row=431)  then meas_n.[Value]  else null END) as m431,
  MAX(CASE WHEN (m.row=432)  then meas_n.[Value]  else null END) as m432,
  MAX(CASE WHEN (m.row=433)  then meas_n.[Value]  else null END) as m433,
  MAX(CASE WHEN (m.row=434)  then meas_n.[Value]  else null END) as m434,
  MAX(CASE WHEN (m.row=435)  then meas_n.[Value]  else null END) as m435,
  MAX(CASE WHEN (m.row=436)  then meas_n.[Value]  else null END) as m436,
  MAX(CASE WHEN (m.row=437)  then meas_n.[Value]  else null END) as m437,
  MAX(CASE WHEN (m.row=438)  then meas_n.[Value]  else null END) as m438,
  MAX(CASE WHEN (m.row=439)  then meas_n.[Value]  else null END) as m439,
  MAX(CASE WHEN (m.row=440)  then meas_n.[Value]  else null END) as m440,
  MAX(CASE WHEN (m.row=441)  then meas_n.[Value]  else null END) as m441,
  MAX(CASE WHEN (m.row=442)  then meas_n.[Value]  else null END) as m442,
  MAX(CASE WHEN (m.row=443)  then meas_n.[Value]  else null END) as m443,
  MAX(CASE WHEN (m.row=444)  then meas_n.[Value]  else null END) as m444,
  MAX(CASE WHEN (m.row=445)  then meas_n.[Value]  else null END) as m445,
  MAX(CASE WHEN (m.row=446)  then meas_n.[Value]  else null END) as m446,
  MAX(CASE WHEN (m.row=447)  then meas_n.[Value]  else null END) as m447,
  MAX(CASE WHEN (m.row=448)  then meas_n.[Value]  else null END) as m448,
  MAX(CASE WHEN (m.row=449)  then meas_n.[Value]  else null END) as m449,
  MAX(CASE WHEN (m.row=450)  then meas_n.[Value]  else null END) as m450
  
      
                      
FROM         #fromview as xr left JOIN
                      Applicant_Measures_Num as meas_n ON
                       (xr.aid = meas_n.Applicant_ID) and
                       (xr.testid = meas_n.Assessment_ID) and
                       (xr.s = meas_n.Session_ID) left join
                        #measures as m
                         on m.Measure_ID = meas_n.Measure_ID
                         
						              
                       
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
