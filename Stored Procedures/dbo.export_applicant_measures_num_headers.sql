SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns header row for numeric measure export
--			    
-- History:		v1
--				v2 increase max measures to 450
-- =============================================
CREATE PROCEDURE [dbo].[export_applicant_measures_num_headers]
	
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
WHERE     textual=0 and assessment_id=@Assessment_ID and Content_Version=@cv

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

--numeric measure names (1-300)
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
  MAX(CASE WHEN (m.row=128) then m.Measure_Name else null END) as m128,
  MAX(CASE WHEN (m.row=129) then m.Measure_Name else null END) as m129,
  MAX(CASE WHEN (m.row=130) then m.Measure_Name else null END) as m130,
  MAX(CASE WHEN (m.row=131) then m.Measure_Name else null END) as m131,
  MAX(CASE WHEN (m.row=132) then m.Measure_Name else null END) as m132,
  MAX(CASE WHEN (m.row=133) then m.Measure_Name else null END) as m133,
  MAX(CASE WHEN (m.row=134) then m.Measure_Name else null END) as m134,
  MAX(CASE WHEN (m.row=135) then m.Measure_Name else null END) as m135,
  MAX(CASE WHEN (m.row=136) then m.Measure_Name else null END) as m136,
  MAX(CASE WHEN (m.row=137) then m.Measure_Name else null END) as m137,
  MAX(CASE WHEN (m.row=138) then m.Measure_Name else null END) as m138,
  MAX(CASE WHEN (m.row=139) then m.Measure_Name else null END) as m139,
  MAX(CASE WHEN (m.row=140) then m.Measure_Name else null END) as m140,
  MAX(CASE WHEN (m.row=141) then m.Measure_Name else null END) as m141,
  MAX(CASE WHEN (m.row=142) then m.Measure_Name else null END) as m142,
  MAX(CASE WHEN (m.row=143) then m.Measure_Name else null END) as m143,
  MAX(CASE WHEN (m.row=144) then m.Measure_Name else null END) as m144,
  MAX(CASE WHEN (m.row=145) then m.Measure_Name else null END) as m145,
  MAX(CASE WHEN (m.row=146) then m.Measure_Name else null END) as m146,
  MAX(CASE WHEN (m.row=147) then m.Measure_Name else null END) as m147,
  MAX(CASE WHEN (m.row=148) then m.Measure_Name else null END) as m148,
  MAX(CASE WHEN (m.row=149) then m.Measure_Name else null END) as m149,
  MAX(CASE WHEN (m.row=150) then m.Measure_Name else null END) as m150,
  MAX(CASE WHEN (m.row=151) then m.Measure_Name else null END) as m151,
  MAX(CASE WHEN (m.row=152) then m.Measure_Name else null END) as m152,
  MAX(CASE WHEN (m.row=153) then m.Measure_Name else null END) as m153,
  MAX(CASE WHEN (m.row=154) then m.Measure_Name else null END) as m154,
  MAX(CASE WHEN (m.row=155) then m.Measure_Name else null END) as m155,
  MAX(CASE WHEN (m.row=156) then m.Measure_Name else null END) as m156,
  MAX(CASE WHEN (m.row=157) then m.Measure_Name else null END) as m157,
  MAX(CASE WHEN (m.row=158) then m.Measure_Name else null END) as m158,
  MAX(CASE WHEN (m.row=159) then m.Measure_Name else null END) as m159,
  MAX(CASE WHEN (m.row=160) then m.Measure_Name else null END) as m160,
  MAX(CASE WHEN (m.row=161) then m.Measure_Name else null END) as m161,
  MAX(CASE WHEN (m.row=162) then m.Measure_Name else null END) as m162,
  MAX(CASE WHEN (m.row=163) then m.Measure_Name else null END) as m163,
  MAX(CASE WHEN (m.row=164) then m.Measure_Name else null END) as m164,
  MAX(CASE WHEN (m.row=165) then m.Measure_Name else null END) as m165,
  MAX(CASE WHEN (m.row=166) then m.Measure_Name else null END) as m166,
  MAX(CASE WHEN (m.row=167) then m.Measure_Name else null END) as m167,
  MAX(CASE WHEN (m.row=168) then m.Measure_Name else null END) as m168,
  MAX(CASE WHEN (m.row=169) then m.Measure_Name else null END) as m169,
  MAX(CASE WHEN (m.row=170) then m.Measure_Name else null END) as m170,
  MAX(CASE WHEN (m.row=171) then m.Measure_Name else null END) as m171,
  MAX(CASE WHEN (m.row=172) then m.Measure_Name else null END) as m172,
  MAX(CASE WHEN (m.row=173) then m.Measure_Name else null END) as m173,
  MAX(CASE WHEN (m.row=174) then m.Measure_Name else null END) as m174,
  MAX(CASE WHEN (m.row=175) then m.Measure_Name else null END) as m175,
  MAX(CASE WHEN (m.row=176) then m.Measure_Name else null END) as m176,
  MAX(CASE WHEN (m.row=177) then m.Measure_Name else null END) as m177,
  MAX(CASE WHEN (m.row=178) then m.Measure_Name else null END) as m178,
  MAX(CASE WHEN (m.row=179) then m.Measure_Name else null END) as m179,
  MAX(CASE WHEN (m.row=180) then m.Measure_Name else null END) as m180,
  MAX(CASE WHEN (m.row=181) then m.Measure_Name else null END) as m181,
  MAX(CASE WHEN (m.row=182) then m.Measure_Name else null END) as m182,
  MAX(CASE WHEN (m.row=183) then m.Measure_Name else null END) as m183,
  MAX(CASE WHEN (m.row=184) then m.Measure_Name else null END) as m184,
  MAX(CASE WHEN (m.row=185) then m.Measure_Name else null END) as m185,
  MAX(CASE WHEN (m.row=186) then m.Measure_Name else null END) as m186,
  MAX(CASE WHEN (m.row=187) then m.Measure_Name else null END) as m187,
  MAX(CASE WHEN (m.row=188) then m.Measure_Name else null END) as m188,
  MAX(CASE WHEN (m.row=189) then m.Measure_Name else null END) as m189,
  MAX(CASE WHEN (m.row=190) then m.Measure_Name else null END) as m190,
  MAX(CASE WHEN (m.row=191) then m.Measure_Name else null END) as m191,
  MAX(CASE WHEN (m.row=192) then m.Measure_Name else null END) as m192,
  MAX(CASE WHEN (m.row=193) then m.Measure_Name else null END) as m193,
  MAX(CASE WHEN (m.row=194) then m.Measure_Name else null END) as m194,
  MAX(CASE WHEN (m.row=195) then m.Measure_Name else null END) as m195,
  MAX(CASE WHEN (m.row=196) then m.Measure_Name else null END) as m196,
  MAX(CASE WHEN (m.row=197) then m.Measure_Name else null END) as m197,
  MAX(CASE WHEN (m.row=198) then m.Measure_Name else null END) as m198,
  MAX(CASE WHEN (m.row=199) then m.Measure_Name else null END) as m199,
  MAX(CASE WHEN (m.row=200) then m.Measure_Name else null END) as m200,
  MAX(CASE WHEN (m.row=201) then m.Measure_Name else null END) as m201,
  MAX(CASE WHEN (m.row=202) then m.Measure_Name else null END) as m202,
  MAX(CASE WHEN (m.row=203) then m.Measure_Name else null END) as m203,
  MAX(CASE WHEN (m.row=204) then m.Measure_Name else null END) as m204,
  MAX(CASE WHEN (m.row=205) then m.Measure_Name else null END) as m205,
  MAX(CASE WHEN (m.row=206) then m.Measure_Name else null END) as m206,
  MAX(CASE WHEN (m.row=207) then m.Measure_Name else null END) as m207,
  MAX(CASE WHEN (m.row=208) then m.Measure_Name else null END) as m208,
  MAX(CASE WHEN (m.row=209) then m.Measure_Name else null END) as m209,
  MAX(CASE WHEN (m.row=210) then m.Measure_Name else null END) as m210,
  MAX(CASE WHEN (m.row=211) then m.Measure_Name else null END) as m211,
  MAX(CASE WHEN (m.row=212) then m.Measure_Name else null END) as m212,
  MAX(CASE WHEN (m.row=213) then m.Measure_Name else null END) as m213,
  MAX(CASE WHEN (m.row=214) then m.Measure_Name else null END) as m214,
  MAX(CASE WHEN (m.row=215) then m.Measure_Name else null END) as m215,
  MAX(CASE WHEN (m.row=216) then m.Measure_Name else null END) as m216,
  MAX(CASE WHEN (m.row=217) then m.Measure_Name else null END) as m217,
  MAX(CASE WHEN (m.row=218) then m.Measure_Name else null END) as m218,
  MAX(CASE WHEN (m.row=219) then m.Measure_Name else null END) as m219,
  MAX(CASE WHEN (m.row=220) then m.Measure_Name else null END) as m220,
  MAX(CASE WHEN (m.row=221) then m.Measure_Name else null END) as m221,
  MAX(CASE WHEN (m.row=222) then m.Measure_Name else null END) as m222,
  MAX(CASE WHEN (m.row=223) then m.Measure_Name else null END) as m223,
  MAX(CASE WHEN (m.row=224) then m.Measure_Name else null END) as m224,
  MAX(CASE WHEN (m.row=225) then m.Measure_Name else null END) as m225,
  MAX(CASE WHEN (m.row=226) then m.Measure_Name else null END) as m226,
  MAX(CASE WHEN (m.row=227) then m.Measure_Name else null END) as m227,
  MAX(CASE WHEN (m.row=228) then m.Measure_Name else null END) as m228,
  MAX(CASE WHEN (m.row=229) then m.Measure_Name else null END) as m229,
  MAX(CASE WHEN (m.row=230) then m.Measure_Name else null END) as m230,
  MAX(CASE WHEN (m.row=231) then m.Measure_Name else null END) as m231,
  MAX(CASE WHEN (m.row=232) then m.Measure_Name else null END) as m232,
  MAX(CASE WHEN (m.row=233) then m.Measure_Name else null END) as m233,
  MAX(CASE WHEN (m.row=234) then m.Measure_Name else null END) as m234,
  MAX(CASE WHEN (m.row=235) then m.Measure_Name else null END) as m235,
  MAX(CASE WHEN (m.row=236) then m.Measure_Name else null END) as m236,
  MAX(CASE WHEN (m.row=237) then m.Measure_Name else null END) as m237,
  MAX(CASE WHEN (m.row=238) then m.Measure_Name else null END) as m238,
  MAX(CASE WHEN (m.row=239) then m.Measure_Name else null END) as m239,
  MAX(CASE WHEN (m.row=240) then m.Measure_Name else null END) as m240,
  MAX(CASE WHEN (m.row=241) then m.Measure_Name else null END) as m241,
  MAX(CASE WHEN (m.row=242) then m.Measure_Name else null END) as m242,
  MAX(CASE WHEN (m.row=243) then m.Measure_Name else null END) as m243,
  MAX(CASE WHEN (m.row=244) then m.Measure_Name else null END) as m244,
  MAX(CASE WHEN (m.row=245) then m.Measure_Name else null END) as m245,
  MAX(CASE WHEN (m.row=246) then m.Measure_Name else null END) as m246,
  MAX(CASE WHEN (m.row=247) then m.Measure_Name else null END) as m247,
  MAX(CASE WHEN (m.row=248) then m.Measure_Name else null END) as m248,
  MAX(CASE WHEN (m.row=249) then m.Measure_Name else null END) as m249,
  MAX(CASE WHEN (m.row=250) then m.Measure_Name else null END) as m250,
  MAX(CASE WHEN (m.row=251) then m.Measure_Name else null END) as m251,
  MAX(CASE WHEN (m.row=252) then m.Measure_Name else null END) as m252,
  MAX(CASE WHEN (m.row=253) then m.Measure_Name else null END) as m253,
  MAX(CASE WHEN (m.row=254) then m.Measure_Name else null END) as m254,
  MAX(CASE WHEN (m.row=255) then m.Measure_Name else null END) as m255,
  MAX(CASE WHEN (m.row=256) then m.Measure_Name else null END) as m256,
  MAX(CASE WHEN (m.row=257) then m.Measure_Name else null END) as m257,
  MAX(CASE WHEN (m.row=258) then m.Measure_Name else null END) as m258,
  MAX(CASE WHEN (m.row=259) then m.Measure_Name else null END) as m259,
  MAX(CASE WHEN (m.row=260) then m.Measure_Name else null END) as m260,
  MAX(CASE WHEN (m.row=261) then m.Measure_Name else null END) as m261,
  MAX(CASE WHEN (m.row=262) then m.Measure_Name else null END) as m262,
  MAX(CASE WHEN (m.row=263) then m.Measure_Name else null END) as m263,
  MAX(CASE WHEN (m.row=264) then m.Measure_Name else null END) as m264,
  MAX(CASE WHEN (m.row=265) then m.Measure_Name else null END) as m265,
  MAX(CASE WHEN (m.row=266) then m.Measure_Name else null END) as m266,
  MAX(CASE WHEN (m.row=267) then m.Measure_Name else null END) as m267,
  MAX(CASE WHEN (m.row=268) then m.Measure_Name else null END) as m268,
  MAX(CASE WHEN (m.row=269) then m.Measure_Name else null END) as m269,
  MAX(CASE WHEN (m.row=270) then m.Measure_Name else null END) as m270,
  MAX(CASE WHEN (m.row=271) then m.Measure_Name else null END) as m271,
  MAX(CASE WHEN (m.row=272) then m.Measure_Name else null END) as m272,
  MAX(CASE WHEN (m.row=273) then m.Measure_Name else null END) as m273,
  MAX(CASE WHEN (m.row=274) then m.Measure_Name else null END) as m274,
  MAX(CASE WHEN (m.row=275) then m.Measure_Name else null END) as m275,
  MAX(CASE WHEN (m.row=276) then m.Measure_Name else null END) as m276,
  MAX(CASE WHEN (m.row=277) then m.Measure_Name else null END) as m277,
  MAX(CASE WHEN (m.row=278) then m.Measure_Name else null END) as m278,
  MAX(CASE WHEN (m.row=279) then m.Measure_Name else null END) as m279,
  MAX(CASE WHEN (m.row=280) then m.Measure_Name else null END) as m280,
  MAX(CASE WHEN (m.row=281) then m.Measure_Name else null END) as m281,
  MAX(CASE WHEN (m.row=282) then m.Measure_Name else null END) as m282,
  MAX(CASE WHEN (m.row=283) then m.Measure_Name else null END) as m283,
  MAX(CASE WHEN (m.row=284) then m.Measure_Name else null END) as m284,
  MAX(CASE WHEN (m.row=285) then m.Measure_Name else null END) as m285,
  MAX(CASE WHEN (m.row=286) then m.Measure_Name else null END) as m286,
  MAX(CASE WHEN (m.row=287) then m.Measure_Name else null END) as m287,
  MAX(CASE WHEN (m.row=288) then m.Measure_Name else null END) as m288,
  MAX(CASE WHEN (m.row=289) then m.Measure_Name else null END) as m289,
  MAX(CASE WHEN (m.row=290) then m.Measure_Name else null END) as m290,
  MAX(CASE WHEN (m.row=291) then m.Measure_Name else null END) as m291,
  MAX(CASE WHEN (m.row=292) then m.Measure_Name else null END) as m292,
  MAX(CASE WHEN (m.row=293) then m.Measure_Name else null END) as m293,
  MAX(CASE WHEN (m.row=294) then m.Measure_Name else null END) as m294,
  MAX(CASE WHEN (m.row=295) then m.Measure_Name else null END) as m295,
  MAX(CASE WHEN (m.row=296) then m.Measure_Name else null END) as m296,
  MAX(CASE WHEN (m.row=297) then m.Measure_Name else null END) as m297,
  MAX(CASE WHEN (m.row=298) then m.Measure_Name else null END) as m298,
  MAX(CASE WHEN (m.row=299) then m.Measure_Name else null END) as m299,
  MAX(CASE WHEN (m.row=300) then m.Measure_Name else null END) as m300,
  MAX(CASE WHEN (m.row=301) then m.Measure_Name else null END) as m301,
  MAX(CASE WHEN (m.row=302) then m.Measure_Name else null END) as m302,
  MAX(CASE WHEN (m.row=303) then m.Measure_Name else null END) as m303,
  MAX(CASE WHEN (m.row=304) then m.Measure_Name else null END) as m304,
  MAX(CASE WHEN (m.row=305) then m.Measure_Name else null END) as m305,
  MAX(CASE WHEN (m.row=306) then m.Measure_Name else null END) as m306,
  MAX(CASE WHEN (m.row=307) then m.Measure_Name else null END) as m307,
  MAX(CASE WHEN (m.row=308) then m.Measure_Name else null END) as m308,
  MAX(CASE WHEN (m.row=309) then m.Measure_Name else null END) as m309,
  MAX(CASE WHEN (m.row=310) then m.Measure_Name else null END) as m310,
  MAX(CASE WHEN (m.row=311) then m.Measure_Name else null END) as m311,
  MAX(CASE WHEN (m.row=312) then m.Measure_Name else null END) as m312,
  MAX(CASE WHEN (m.row=313) then m.Measure_Name else null END) as m313,
  MAX(CASE WHEN (m.row=314) then m.Measure_Name else null END) as m314,
  MAX(CASE WHEN (m.row=315) then m.Measure_Name else null END) as m315,
  MAX(CASE WHEN (m.row=316) then m.Measure_Name else null END) as m316,
  MAX(CASE WHEN (m.row=317) then m.Measure_Name else null END) as m317,
  MAX(CASE WHEN (m.row=318) then m.Measure_Name else null END) as m318,
  MAX(CASE WHEN (m.row=319) then m.Measure_Name else null END) as m319,
  MAX(CASE WHEN (m.row=320) then m.Measure_Name else null END) as m320,
  MAX(CASE WHEN (m.row=321) then m.Measure_Name else null END) as m321,
  MAX(CASE WHEN (m.row=322) then m.Measure_Name else null END) as m322,
  MAX(CASE WHEN (m.row=323) then m.Measure_Name else null END) as m323,
  MAX(CASE WHEN (m.row=324) then m.Measure_Name else null END) as m324,
  MAX(CASE WHEN (m.row=325) then m.Measure_Name else null END) as m325,
  MAX(CASE WHEN (m.row=326) then m.Measure_Name else null END) as m326,
  MAX(CASE WHEN (m.row=327) then m.Measure_Name else null END) as m327,
  MAX(CASE WHEN (m.row=328) then m.Measure_Name else null END) as m328,
  MAX(CASE WHEN (m.row=329) then m.Measure_Name else null END) as m329,
  MAX(CASE WHEN (m.row=330) then m.Measure_Name else null END) as m330,
  MAX(CASE WHEN (m.row=331) then m.Measure_Name else null END) as m331,
  MAX(CASE WHEN (m.row=332) then m.Measure_Name else null END) as m332,
  MAX(CASE WHEN (m.row=333) then m.Measure_Name else null END) as m333,
  MAX(CASE WHEN (m.row=334) then m.Measure_Name else null END) as m334,
  MAX(CASE WHEN (m.row=335) then m.Measure_Name else null END) as m335,
  MAX(CASE WHEN (m.row=336) then m.Measure_Name else null END) as m336,
  MAX(CASE WHEN (m.row=337) then m.Measure_Name else null END) as m337,
  MAX(CASE WHEN (m.row=338) then m.Measure_Name else null END) as m338,
  MAX(CASE WHEN (m.row=339) then m.Measure_Name else null END) as m339,
  MAX(CASE WHEN (m.row=340) then m.Measure_Name else null END) as m340,
  MAX(CASE WHEN (m.row=341) then m.Measure_Name else null END) as m341,
  MAX(CASE WHEN (m.row=342) then m.Measure_Name else null END) as m342,
  MAX(CASE WHEN (m.row=343) then m.Measure_Name else null END) as m343,
  MAX(CASE WHEN (m.row=344) then m.Measure_Name else null END) as m344,
  MAX(CASE WHEN (m.row=345) then m.Measure_Name else null END) as m345,
  MAX(CASE WHEN (m.row=346) then m.Measure_Name else null END) as m346,
  MAX(CASE WHEN (m.row=347) then m.Measure_Name else null END) as m347,
  MAX(CASE WHEN (m.row=348) then m.Measure_Name else null END) as m348,
  MAX(CASE WHEN (m.row=349) then m.Measure_Name else null END) as m349,
  MAX(CASE WHEN (m.row=350) then m.Measure_Name else null END) as m350,
  MAX(CASE WHEN (m.row=351) then m.Measure_Name else null END) as m351,
  MAX(CASE WHEN (m.row=352) then m.Measure_Name else null END) as m352,
  MAX(CASE WHEN (m.row=353) then m.Measure_Name else null END) as m353,
  MAX(CASE WHEN (m.row=354) then m.Measure_Name else null END) as m354,
  MAX(CASE WHEN (m.row=355) then m.Measure_Name else null END) as m355,
  MAX(CASE WHEN (m.row=356) then m.Measure_Name else null END) as m356,
  MAX(CASE WHEN (m.row=357) then m.Measure_Name else null END) as m357,
  MAX(CASE WHEN (m.row=358) then m.Measure_Name else null END) as m358,
  MAX(CASE WHEN (m.row=359) then m.Measure_Name else null END) as m359,
  MAX(CASE WHEN (m.row=360) then m.Measure_Name else null END) as m360,
  MAX(CASE WHEN (m.row=361) then m.Measure_Name else null END) as m361,
  MAX(CASE WHEN (m.row=362) then m.Measure_Name else null END) as m362,
  MAX(CASE WHEN (m.row=363) then m.Measure_Name else null END) as m363,
  MAX(CASE WHEN (m.row=364) then m.Measure_Name else null END) as m364,
  MAX(CASE WHEN (m.row=365) then m.Measure_Name else null END) as m365,
  MAX(CASE WHEN (m.row=366) then m.Measure_Name else null END) as m366,
  MAX(CASE WHEN (m.row=367) then m.Measure_Name else null END) as m367,
  MAX(CASE WHEN (m.row=368) then m.Measure_Name else null END) as m368,
  MAX(CASE WHEN (m.row=369) then m.Measure_Name else null END) as m369,
  MAX(CASE WHEN (m.row=370) then m.Measure_Name else null END) as m370,
  MAX(CASE WHEN (m.row=371) then m.Measure_Name else null END) as m371,
  MAX(CASE WHEN (m.row=372) then m.Measure_Name else null END) as m372,
  MAX(CASE WHEN (m.row=373) then m.Measure_Name else null END) as m373,
  MAX(CASE WHEN (m.row=374) then m.Measure_Name else null END) as m374,
  MAX(CASE WHEN (m.row=375) then m.Measure_Name else null END) as m375,
  MAX(CASE WHEN (m.row=376) then m.Measure_Name else null END) as m376,
  MAX(CASE WHEN (m.row=377) then m.Measure_Name else null END) as m377,
  MAX(CASE WHEN (m.row=378) then m.Measure_Name else null END) as m378,
  MAX(CASE WHEN (m.row=379) then m.Measure_Name else null END) as m379,
  MAX(CASE WHEN (m.row=380) then m.Measure_Name else null END) as m380,
  MAX(CASE WHEN (m.row=381) then m.Measure_Name else null END) as m381,
  MAX(CASE WHEN (m.row=382) then m.Measure_Name else null END) as m382,
  MAX(CASE WHEN (m.row=383) then m.Measure_Name else null END) as m383,
  MAX(CASE WHEN (m.row=384) then m.Measure_Name else null END) as m384,
  MAX(CASE WHEN (m.row=385) then m.Measure_Name else null END) as m385,
  MAX(CASE WHEN (m.row=386) then m.Measure_Name else null END) as m386,
  MAX(CASE WHEN (m.row=387) then m.Measure_Name else null END) as m387,
  MAX(CASE WHEN (m.row=388) then m.Measure_Name else null END) as m388,
  MAX(CASE WHEN (m.row=389) then m.Measure_Name else null END) as m389,
  MAX(CASE WHEN (m.row=390) then m.Measure_Name else null END) as m390,
  MAX(CASE WHEN (m.row=391) then m.Measure_Name else null END) as m391,
  MAX(CASE WHEN (m.row=392) then m.Measure_Name else null END) as m392,
  MAX(CASE WHEN (m.row=393) then m.Measure_Name else null END) as m393,
  MAX(CASE WHEN (m.row=394) then m.Measure_Name else null END) as m394,
  MAX(CASE WHEN (m.row=395) then m.Measure_Name else null END) as m395,
  MAX(CASE WHEN (m.row=396) then m.Measure_Name else null END) as m396,
  MAX(CASE WHEN (m.row=397) then m.Measure_Name else null END) as m397,
  MAX(CASE WHEN (m.row=398) then m.Measure_Name else null END) as m398,
  MAX(CASE WHEN (m.row=399) then m.Measure_Name else null END) as m399,
  MAX(CASE WHEN (m.row=400) then m.Measure_Name else null END) as m400,
  MAX(CASE WHEN (m.row=401) then m.Measure_Name else null END) as m401,
  MAX(CASE WHEN (m.row=402) then m.Measure_Name else null END) as m402,
  MAX(CASE WHEN (m.row=403) then m.Measure_Name else null END) as m403,
  MAX(CASE WHEN (m.row=404) then m.Measure_Name else null END) as m404,
  MAX(CASE WHEN (m.row=405) then m.Measure_Name else null END) as m405,
  MAX(CASE WHEN (m.row=406) then m.Measure_Name else null END) as m406,
  MAX(CASE WHEN (m.row=407) then m.Measure_Name else null END) as m407,
  MAX(CASE WHEN (m.row=408) then m.Measure_Name else null END) as m408,
  MAX(CASE WHEN (m.row=409) then m.Measure_Name else null END) as m409,
  MAX(CASE WHEN (m.row=410) then m.Measure_Name else null END) as m410,
  MAX(CASE WHEN (m.row=411) then m.Measure_Name else null END) as m411,
  MAX(CASE WHEN (m.row=412) then m.Measure_Name else null END) as m412,
  MAX(CASE WHEN (m.row=413) then m.Measure_Name else null END) as m413,
  MAX(CASE WHEN (m.row=414) then m.Measure_Name else null END) as m414,
  MAX(CASE WHEN (m.row=415) then m.Measure_Name else null END) as m415,
  MAX(CASE WHEN (m.row=416) then m.Measure_Name else null END) as m416,
  MAX(CASE WHEN (m.row=417) then m.Measure_Name else null END) as m417,
  MAX(CASE WHEN (m.row=418) then m.Measure_Name else null END) as m418,
  MAX(CASE WHEN (m.row=419) then m.Measure_Name else null END) as m419,
  MAX(CASE WHEN (m.row=420) then m.Measure_Name else null END) as m420,
  MAX(CASE WHEN (m.row=421) then m.Measure_Name else null END) as m421,
  MAX(CASE WHEN (m.row=422) then m.Measure_Name else null END) as m422,
  MAX(CASE WHEN (m.row=423) then m.Measure_Name else null END) as m423,
  MAX(CASE WHEN (m.row=424) then m.Measure_Name else null END) as m424,
  MAX(CASE WHEN (m.row=425) then m.Measure_Name else null END) as m425,
  MAX(CASE WHEN (m.row=426) then m.Measure_Name else null END) as m426,
  MAX(CASE WHEN (m.row=427) then m.Measure_Name else null END) as m427,
  MAX(CASE WHEN (m.row=428) then m.Measure_Name else null END) as m428,
  MAX(CASE WHEN (m.row=429) then m.Measure_Name else null END) as m429,
  MAX(CASE WHEN (m.row=430) then m.Measure_Name else null END) as m430,
  MAX(CASE WHEN (m.row=431) then m.Measure_Name else null END) as m431,
  MAX(CASE WHEN (m.row=432) then m.Measure_Name else null END) as m432,
  MAX(CASE WHEN (m.row=433) then m.Measure_Name else null END) as m433,
  MAX(CASE WHEN (m.row=434) then m.Measure_Name else null END) as m434,
  MAX(CASE WHEN (m.row=435) then m.Measure_Name else null END) as m435,
  MAX(CASE WHEN (m.row=436) then m.Measure_Name else null END) as m436,
  MAX(CASE WHEN (m.row=437) then m.Measure_Name else null END) as m437,
  MAX(CASE WHEN (m.row=438) then m.Measure_Name else null END) as m438,
  MAX(CASE WHEN (m.row=439) then m.Measure_Name else null END) as m439,
  MAX(CASE WHEN (m.row=440) then m.Measure_Name else null END) as m440,
  MAX(CASE WHEN (m.row=441) then m.Measure_Name else null END) as m441,
  MAX(CASE WHEN (m.row=442) then m.Measure_Name else null END) as m442,
  MAX(CASE WHEN (m.row=443) then m.Measure_Name else null END) as m443,
  MAX(CASE WHEN (m.row=444) then m.Measure_Name else null END) as m444,
  MAX(CASE WHEN (m.row=445) then m.Measure_Name else null END) as m445,
  MAX(CASE WHEN (m.row=446) then m.Measure_Name else null END) as m446,
  MAX(CASE WHEN (m.row=447) then m.Measure_Name else null END) as m447,
  MAX(CASE WHEN (m.row=448) then m.Measure_Name else null END) as m448,
  MAX(CASE WHEN (m.row=449) then m.Measure_Name else null END) as m449,
  MAX(CASE WHEN (m.row=450) then m.Measure_Name else null END) as m450

from #measures AS m left JOIN
                      Applicant_Items AS a on m.Assessment_ID = a.Assessment_ID
					  

drop table #measures
GO
