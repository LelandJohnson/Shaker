SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns real column header names
--			    (dynamic dim and applicant data names for vjt)
-- History:		v1
--				v1.1 removed Dimension_Name from Dimension_Name,SPSS_Variable combo header
-- =============================================
CREATE PROCEDURE [dbo].[export_dimensions_headers]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint,
	@cv float = 1,	
	@reqtreatment varchar(16) = 'all' --how to decide which req(s) to show, 'all' 'latest' or 'kpmg' style		
	)
	
AS
	SET NOCOUNT ON

declare @Scoring_Version real

select top 1 @Scoring_Version = Scoring_Version from Applicant_Sessions where
(Assessment_ID = @Assessment_ID) AND (@Start_Date_From IS NULL OR
                      [Start_Date] >= @Start_Date_From) AND (@Start_Date_To IS NULL OR
                      [Start_Date] <= @Start_Date_To) AND (@Completion_Date_From IS NULL OR
                      Completion_Date >= @Completion_Date_From) AND (@Completion_Date_To IS NULL OR
                      Completion_Date <= @Completion_Date_To) AND
                      
					  ( 
					  ((@Status_Code1 is null) or (Status_Code = @Status_Code1)) and
					  ((@Status_Code2 is null) or (Status_Code = @Status_Code2))
					  )		              
					  order by Scoring_Version desc

  
	
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

--dimension names
    MAX(CASE WHEN (Dimension_ID = 1) then SPSS_Variable else null END) as d1,
    MAX(CASE WHEN (Dimension_ID = 2) then SPSS_Variable else null END) as d2,
    MAX(CASE WHEN (Dimension_ID = 3) then SPSS_Variable else null END) as d3,
    MAX(CASE WHEN (Dimension_ID = 4) then SPSS_Variable else null END) as d4,
    MAX(CASE WHEN (Dimension_ID = 5) then SPSS_Variable else null END) as d5,
    MAX(CASE WHEN (Dimension_ID = 6) then SPSS_Variable else null END) as d6,
    MAX(CASE WHEN (Dimension_ID = 7) then SPSS_Variable else null END) as d7,
    MAX(CASE WHEN (Dimension_ID = 8) then SPSS_Variable else null END) as d8,
    MAX(CASE WHEN (Dimension_ID = 9) then SPSS_Variable else null END) as d9,
    MAX(CASE WHEN (Dimension_ID = 10) then SPSS_Variable else null END) as d10,
    MAX(CASE WHEN (Dimension_ID = 11) then SPSS_Variable else null END) as d11,
    MAX(CASE WHEN (Dimension_ID = 12) then SPSS_Variable else null END) as d12,
    MAX(CASE WHEN (Dimension_ID = 13) then SPSS_Variable else null END) as d13,
    MAX(CASE WHEN (Dimension_ID = 14) then SPSS_Variable else null END) as d14,
    MAX(CASE WHEN (Dimension_ID = 15) then SPSS_Variable else null END) as d15,
    MAX(CASE WHEN (Dimension_ID = 16) then SPSS_Variable else null END) as d16,
    MAX(CASE WHEN (Dimension_ID = 17) then SPSS_Variable else null END) as d17,
    MAX(CASE WHEN (Dimension_ID = 18) then SPSS_Variable else null END) as d18,
    MAX(CASE WHEN (Dimension_ID = 19) then SPSS_Variable else null END) as d19,
    MAX(CASE WHEN (Dimension_ID = 20) then SPSS_Variable else null END) as d20,
    MAX(CASE WHEN (Dimension_ID = 21) then SPSS_Variable else null END) as d21,
    MAX(CASE WHEN (Dimension_ID = 22) then SPSS_Variable else null END) as d22,
    MAX(CASE WHEN (Dimension_ID = 23) then SPSS_Variable else null END) as d23,
    MAX(CASE WHEN (Dimension_ID = 24) then SPSS_Variable else null END) as d24

from Dimensions AS d left JOIN
                      Applicant_Items AS a on d.Assessment_ID = a.Assessment_ID

where d.Scoring_Version=isnull(@Scoring_Version, 1) and d.Assessment_ID = @Assessment_ID


GO
