SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[export_applicant_basicinfo]
	
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
	
SELECT     ap.Applicant_ID as aid, [asn].Assessment_ID as TestID, [asn].Session_ID as s, ap.First_Name as fn, ap.Last_Name as ln, ap.Login_ID as id, ap.Employee_ID as emp, ap.Other_ID as id2, [asn].Status_Code as SC,
		  convert(nvarchar(100),[asn].[Start_Date],20) as SDate,
		 convert(nvarchar(100),[asn].Completion_Date,20) as CDate,  [asn].Results_Overall as Score, asn.Scoring_Version as scorever, asn.Content_Version as cv
		              
  
FROM         Applicants AS ap INNER JOIN
                      Applicant_Sessions AS [asn] ON ap.Applicant_ID = [asn].Applicant_ID 
                      
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) and 
		  
		  ( 
		  ((@Status_Code1 is null) or ([asn].Status_Code = @Status_Code1)) and
		  ((@Status_Code2 is null) or ([asn].Status_Code = @Status_Code2))
		  )		  
		  

group by ap.Applicant_ID, ap.First_Name, ap.Last_Name, ap.Login_ID, ap.Employee_ID, ap.Other_ID, asn.Status_Code,
		 asn.Assessment_ID, asn.[Start_Date], asn.Completion_Date, asn.Session_ID, asn.Results_Overall,
		 asn.Scoring_Version , asn.Content_Version 
		 
GO
