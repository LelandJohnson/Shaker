SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns header row for fb text measure export
--			    
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[export_feedback_text_headers]
	
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
  MAX(CASE WHEN (m.fbnum=1) then m.Measure_Name else null END) as m1,
  MAX(CASE WHEN (m.fbnum=2) then m.Measure_Name else null END) as m2,
  MAX(CASE WHEN (m.fbnum=3) then m.Measure_Name else null END) as m3,
  MAX(CASE WHEN (m.fbnum=4) then m.Measure_Name else null END) as m4,
  MAX(CASE WHEN (m.fbnum=5) then m.Measure_Name else null END) as m5,
  MAX(CASE WHEN (m.fbnum=6) then m.Measure_Name else null END) as m6,
  MAX(CASE WHEN (m.fbnum=7) then m.Measure_Name else null END) as m7,
  MAX(CASE WHEN (m.fbnum=8) then m.Measure_Name else null END) as m8,
  MAX(CASE WHEN (m.fbnum=9) then m.Measure_Name else null END) as m9,
  MAX(CASE WHEN (m.fbnum=10) then m.Measure_Name else null END) as m10,
  MAX(CASE WHEN (m.fbnum=11) then m.Measure_Name else null END) as m11,
  MAX(CASE WHEN (m.fbnum=12) then m.Measure_Name else null END) as m12,
  MAX(CASE WHEN (m.fbnum=13) then m.Measure_Name else null END) as m13,
  MAX(CASE WHEN (m.fbnum=14) then m.Measure_Name else null END) as m14,
  MAX(CASE WHEN (m.fbnum=15) then m.Measure_Name else null END) as m15,
  MAX(CASE WHEN (m.fbnum=16) then m.Measure_Name else null END) as m16

from dbo.get_feedback_measure_function(@Assessment_ID, 1, @cv) as m left JOIN
                      Applicant_Items AS a on m.Assessment_ID = a.Assessment_ID



GO
