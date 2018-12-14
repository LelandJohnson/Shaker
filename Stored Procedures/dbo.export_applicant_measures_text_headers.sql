SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns header row for text measure export
--			    
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[export_applicant_measures_text_headers]
	
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
	
 CREATE TABLE #measures
(
 Assessment_ID tinyint,
 [row] int,
 Measure_ID smallint,
 Content_Version real,
 Measure_Name varchar(50)
)

insert into #measures (Assessment_ID, [row], Measure_ID, Content_Version, Measure_Name)
SELECT   Assessment_ID, ROW_NUMBER() OVER (ORDER BY Measure_ID) AS row,
 Measure_ID, Content_Version, Measure_Name
FROM         dbo.Measures
WHERE     textual=1 and assessment_id=@Assessment_ID and Content_Version=@cv

select 'Applicant_ID','Test_ID','Session_ID','Req','FirstName','LastName','ID','Employee_ID','ID2','Status_Code',
       'Session_Date','Applicant_Start_Date','Last_Activity_Date','Completion_Date','Total_Time','Question_Time',
       'Score','Scoring_Version','Content_Version','Language','Alt_Ver',

    MAX(CASE WHEN (Item_ID = 1) then Data_Title else null END) as ad1,
    MAX(CASE WHEN (Item_ID = 2) then Data_Title else null END) as ad2,
    MAX(CASE WHEN (Item_ID = 3) then Data_Title else null END) as ad3,
    MAX(CASE WHEN (Item_ID = 4) then Data_Title else null END) as ad4,
    MAX(CASE WHEN (Item_ID = 5) then Data_Title else null END) as ad5,
    MAX(CASE WHEN (Item_ID = 6) then Data_Title else null END) as ad6,
    MAX(CASE WHEN (Item_ID = 7) then Data_Title else null END) as ad7,
    MAX(CASE WHEN (Item_ID = 8) then Data_Title else null END) as ad8,
    MAX(CASE WHEN (Item_ID = 9) then Data_Title else null END) as ad9,
    MAX(CASE WHEN (Item_ID = 10) then Data_Title else null END) as ad10,
    MAX(CASE WHEN (Item_ID = 11) then Data_Title else null END) as ad11,
    MAX(CASE WHEN (Item_ID = 12) then Data_Title else null END) as ad12,
    MAX(CASE WHEN (Item_ID = 13) then Data_Title else null END) as ad13,
    MAX(CASE WHEN (Item_ID = 14) then Data_Title else null END) as ad14,
    MAX(CASE WHEN (Item_ID = 15) then Data_Title else null END) as ad15,
    MAX(CASE WHEN (Item_ID = 16) then Data_Title else null END) as ad16,
    MAX(CASE WHEN (Item_ID = 17) then Data_Title else null END) as ad17,
    MAX(CASE WHEN (Item_ID = 18) then Data_Title else null END) as ad18,
    MAX(CASE WHEN (Item_ID = 19) then Data_Title else null END) as ad19,
    MAX(CASE WHEN (Item_ID = 20) then Data_Title else null END) as ad20,
    MAX(CASE WHEN (Item_ID = 21) then Data_Title else null END) as ad21,
    MAX(CASE WHEN (Item_ID = 22) then Data_Title else null END) as ad22,
    MAX(CASE WHEN (Item_ID = 23) then Data_Title else null END) as ad23,
    MAX(CASE WHEN (Item_ID = 24) then Data_Title else null END) as ad24,
    MAX(CASE WHEN (Item_ID = 25) then Data_Title else null END) as ad25,
    MAX(CASE WHEN (Item_ID = 26) then Data_Title else null END) as ad26,
    MAX(CASE WHEN (Item_ID = 27) then Data_Title else null END) as ad27,
    MAX(CASE WHEN (Item_ID = 28) then Data_Title else null END) as ad28,
    MAX(CASE WHEN (Item_ID = 29) then Data_Title else null END) as ad29,
    MAX(CASE WHEN (Item_ID = 30) then Data_Title else null END) as ad30,
    MAX(CASE WHEN (Item_ID = 31) then Data_Title else null END) as ad31,
    MAX(CASE WHEN (Item_ID = 32) then Data_Title else null END) as ad32,

--numeric measure names (1-128)
  MAX(CASE WHEN (m.row=1) then m.Measure_Name else null END) as m1,
  MAX(CASE WHEN (m.row=2) then m.Measure_Name else null END) as m2,
  MAX(CASE WHEN (m.row=3) then m.Measure_Name else null END) as m3,
  MAX(CASE WHEN (m.row=4) then m.Measure_Name else null END) as m4,
  MAX(CASE WHEN (m.row=5) then m.Measure_Name else null END) as m5,
  MAX(CASE WHEN (m.row=6) then m.Measure_Name else null END) as m6,
  MAX(CASE WHEN (m.row=7) then m.Measure_Name else null END) as m7,
  MAX(CASE WHEN (m.row=8) then m.Measure_Name else null END) as m8,
  MAX(CASE WHEN (m.row=9) then m.Measure_Name else null END) as m9,
  MAX(CASE WHEN (m.row=10) then m.Measure_Name else null END) as m10,
  MAX(CASE WHEN (m.row=11) then m.Measure_Name else null END) as m11,
  MAX(CASE WHEN (m.row=12) then m.Measure_Name else null END) as m12,
  MAX(CASE WHEN (m.row=13) then m.Measure_Name else null END) as m13,
  MAX(CASE WHEN (m.row=14) then m.Measure_Name else null END) as m14,
  MAX(CASE WHEN (m.row=15) then m.Measure_Name else null END) as m15,
  MAX(CASE WHEN (m.row=16) then m.Measure_Name else null END) as m16,
  MAX(CASE WHEN (m.row=17) then m.Measure_Name else null END) as m17,
  MAX(CASE WHEN (m.row=18) then m.Measure_Name else null END) as m18,
  MAX(CASE WHEN (m.row=19) then m.Measure_Name else null END) as m19,
  MAX(CASE WHEN (m.row=20) then m.Measure_Name else null END) as m20,
  MAX(CASE WHEN (m.row=21) then m.Measure_Name else null END) as m21,
  MAX(CASE WHEN (m.row=22) then m.Measure_Name else null END) as m22,
  MAX(CASE WHEN (m.row=23) then m.Measure_Name else null END) as m23,
  MAX(CASE WHEN (m.row=24) then m.Measure_Name else null END) as m24,
  MAX(CASE WHEN (m.row=25) then m.Measure_Name else null END) as m25,
  MAX(CASE WHEN (m.row=26) then m.Measure_Name else null END) as m26,
  MAX(CASE WHEN (m.row=27) then m.Measure_Name else null END) as m27,
  MAX(CASE WHEN (m.row=28) then m.Measure_Name else null END) as m28,
  MAX(CASE WHEN (m.row=29) then m.Measure_Name else null END) as m29,
  MAX(CASE WHEN (m.row=30) then m.Measure_Name else null END) as m30,
  MAX(CASE WHEN (m.row=31) then m.Measure_Name else null END) as m31,
  MAX(CASE WHEN (m.row=32) then m.Measure_Name else null END) as m32,
  MAX(CASE WHEN (m.row=33) then m.Measure_Name else null END) as m33,
  MAX(CASE WHEN (m.row=34) then m.Measure_Name else null END) as m34,
  MAX(CASE WHEN (m.row=35) then m.Measure_Name else null END) as m35,
  MAX(CASE WHEN (m.row=36) then m.Measure_Name else null END) as m36,
  MAX(CASE WHEN (m.row=37) then m.Measure_Name else null END) as m37,
  MAX(CASE WHEN (m.row=38) then m.Measure_Name else null END) as m38,
  MAX(CASE WHEN (m.row=39) then m.Measure_Name else null END) as m39,
  MAX(CASE WHEN (m.row=40) then m.Measure_Name else null END) as m40,
  MAX(CASE WHEN (m.row=41) then m.Measure_Name else null END) as m41,
  MAX(CASE WHEN (m.row=42) then m.Measure_Name else null END) as m42,
  MAX(CASE WHEN (m.row=43) then m.Measure_Name else null END) as m43,
  MAX(CASE WHEN (m.row=44) then m.Measure_Name else null END) as m44,
  MAX(CASE WHEN (m.row=45) then m.Measure_Name else null END) as m45,
  MAX(CASE WHEN (m.row=46) then m.Measure_Name else null END) as m46,
  MAX(CASE WHEN (m.row=47) then m.Measure_Name else null END) as m47,
  MAX(CASE WHEN (m.row=48) then m.Measure_Name else null END) as m48,
  MAX(CASE WHEN (m.row=49) then m.Measure_Name else null END) as m49,
  MAX(CASE WHEN (m.row=50) then m.Measure_Name else null END) as m50,
  MAX(CASE WHEN (m.row=51) then m.Measure_Name else null END) as m51,
  MAX(CASE WHEN (m.row=52) then m.Measure_Name else null END) as m52,
  MAX(CASE WHEN (m.row=53) then m.Measure_Name else null END) as m53,
  MAX(CASE WHEN (m.row=54) then m.Measure_Name else null END) as m54,
  MAX(CASE WHEN (m.row=55) then m.Measure_Name else null END) as m55,
  MAX(CASE WHEN (m.row=56) then m.Measure_Name else null END) as m56,
  MAX(CASE WHEN (m.row=57) then m.Measure_Name else null END) as m57,
  MAX(CASE WHEN (m.row=58) then m.Measure_Name else null END) as m58,
  MAX(CASE WHEN (m.row=59) then m.Measure_Name else null END) as m59,
  MAX(CASE WHEN (m.row=60) then m.Measure_Name else null END) as m60,
  MAX(CASE WHEN (m.row=61) then m.Measure_Name else null END) as m61,
  MAX(CASE WHEN (m.row=62) then m.Measure_Name else null END) as m62,
  MAX(CASE WHEN (m.row=63) then m.Measure_Name else null END) as m63,
  MAX(CASE WHEN (m.row=64) then m.Measure_Name else null END) as m64,
  MAX(CASE WHEN (m.row=65) then m.Measure_Name else null END) as m65,
  MAX(CASE WHEN (m.row=66) then m.Measure_Name else null END) as m66,
  MAX(CASE WHEN (m.row=67) then m.Measure_Name else null END) as m67,
  MAX(CASE WHEN (m.row=68) then m.Measure_Name else null END) as m68,
  MAX(CASE WHEN (m.row=69) then m.Measure_Name else null END) as m69,
  MAX(CASE WHEN (m.row=70) then m.Measure_Name else null END) as m70,
  MAX(CASE WHEN (m.row=71) then m.Measure_Name else null END) as m71,
  MAX(CASE WHEN (m.row=72) then m.Measure_Name else null END) as m72,
  MAX(CASE WHEN (m.row=73) then m.Measure_Name else null END) as m73,
  MAX(CASE WHEN (m.row=74) then m.Measure_Name else null END) as m74,
  MAX(CASE WHEN (m.row=75) then m.Measure_Name else null END) as m75,
  MAX(CASE WHEN (m.row=76) then m.Measure_Name else null END) as m76,
  MAX(CASE WHEN (m.row=77) then m.Measure_Name else null END) as m77,
  MAX(CASE WHEN (m.row=78) then m.Measure_Name else null END) as m78,
  MAX(CASE WHEN (m.row=79) then m.Measure_Name else null END) as m79,
  MAX(CASE WHEN (m.row=80) then m.Measure_Name else null END) as m80,
  MAX(CASE WHEN (m.row=81) then m.Measure_Name else null END) as m81,
  MAX(CASE WHEN (m.row=82) then m.Measure_Name else null END) as m82,
  MAX(CASE WHEN (m.row=83) then m.Measure_Name else null END) as m83,
  MAX(CASE WHEN (m.row=84) then m.Measure_Name else null END) as m84,
  MAX(CASE WHEN (m.row=85) then m.Measure_Name else null END) as m85,
  MAX(CASE WHEN (m.row=86) then m.Measure_Name else null END) as m86,
  MAX(CASE WHEN (m.row=87) then m.Measure_Name else null END) as m87,
  MAX(CASE WHEN (m.row=88) then m.Measure_Name else null END) as m88,
  MAX(CASE WHEN (m.row=89) then m.Measure_Name else null END) as m89,
  MAX(CASE WHEN (m.row=90) then m.Measure_Name else null END) as m90,
  MAX(CASE WHEN (m.row=91) then m.Measure_Name else null END) as m91,
  MAX(CASE WHEN (m.row=92) then m.Measure_Name else null END) as m92,
  MAX(CASE WHEN (m.row=93) then m.Measure_Name else null END) as m93,
  MAX(CASE WHEN (m.row=94) then m.Measure_Name else null END) as m94,
  MAX(CASE WHEN (m.row=95) then m.Measure_Name else null END) as m95,
  MAX(CASE WHEN (m.row=96) then m.Measure_Name else null END) as m96,
  MAX(CASE WHEN (m.row=97) then m.Measure_Name else null END) as m97,
  MAX(CASE WHEN (m.row=98) then m.Measure_Name else null END) as m98,
  MAX(CASE WHEN (m.row=99) then m.Measure_Name else null END) as m99,
  MAX(CASE WHEN (m.row=100) then m.Measure_Name else null END) as m100,
  MAX(CASE WHEN (m.row=101) then m.Measure_Name else null END) as m101,
  MAX(CASE WHEN (m.row=102) then m.Measure_Name else null END) as m102,
  MAX(CASE WHEN (m.row=103) then m.Measure_Name else null END) as m103,
  MAX(CASE WHEN (m.row=104) then m.Measure_Name else null END) as m104,
  MAX(CASE WHEN (m.row=105) then m.Measure_Name else null END) as m105,
  MAX(CASE WHEN (m.row=106) then m.Measure_Name else null END) as m106,
  MAX(CASE WHEN (m.row=107) then m.Measure_Name else null END) as m107,
  MAX(CASE WHEN (m.row=108) then m.Measure_Name else null END) as m108,
  MAX(CASE WHEN (m.row=109) then m.Measure_Name else null END) as m109,
  MAX(CASE WHEN (m.row=110) then m.Measure_Name else null END) as m110,
  MAX(CASE WHEN (m.row=111) then m.Measure_Name else null END) as m111,
  MAX(CASE WHEN (m.row=112) then m.Measure_Name else null END) as m112,
  MAX(CASE WHEN (m.row=113) then m.Measure_Name else null END) as m113,
  MAX(CASE WHEN (m.row=114) then m.Measure_Name else null END) as m114,
  MAX(CASE WHEN (m.row=115) then m.Measure_Name else null END) as m115,
  MAX(CASE WHEN (m.row=116) then m.Measure_Name else null END) as m116,
  MAX(CASE WHEN (m.row=117) then m.Measure_Name else null END) as m117,
  MAX(CASE WHEN (m.row=118) then m.Measure_Name else null END) as m118,
  MAX(CASE WHEN (m.row=119) then m.Measure_Name else null END) as m119,
  MAX(CASE WHEN (m.row=120) then m.Measure_Name else null END) as m120,
  MAX(CASE WHEN (m.row=121) then m.Measure_Name else null END) as m121,
  MAX(CASE WHEN (m.row=122) then m.Measure_Name else null END) as m122,
  MAX(CASE WHEN (m.row=123) then m.Measure_Name else null END) as m123,
  MAX(CASE WHEN (m.row=124) then m.Measure_Name else null END) as m124,
  MAX(CASE WHEN (m.row=125) then m.Measure_Name else null END) as m125,
  MAX(CASE WHEN (m.row=126) then m.Measure_Name else null END) as m126,
  MAX(CASE WHEN (m.row=127) then m.Measure_Name else null END) as m127,
  MAX(CASE WHEN (m.row=128) then m.Measure_Name else null END) as m128
  

from #measures AS m left JOIN
                      Applicant_Items AS a on m.Assessment_ID = a.Assessment_ID


drop table #measures
GO
