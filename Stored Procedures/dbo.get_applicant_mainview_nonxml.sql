SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[get_applicant_mainview_nonxml]
	
	(
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code smallint
	)
	
AS
	SET NOCOUNT ON
	
SELECT     ap.Applicant_ID as aid, ap.First_Name, ap.Last_Name, ap.Login_ID, ap.Employee_ID, [asn].Status_Code as SC,
		 [asn].Assessment_ID as TestID, convert(nvarchar(100),[asn].[Start_Date],20) as SDate,
		 convert(nvarchar(100),[asn].Completion_Date,20) as CDate, [asn].Session_ID, [asn].Results_Overall as Score, 
		              ad.Requisition_ID as r ,
                      ad.Item_Value as Val , ad.Item_ID as ID
FROM         Applicants AS ap INNER JOIN
                      Applicant_Sessions AS [asn] ON ap.Applicant_ID = [asn].Applicant_ID LEFT JOIN
                      Applicant_Data AS ad ON [asn].Applicant_ID = ad.Applicant_ID and [asn].Session_ID = ad.Session_ID 
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].Start_Date>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].Start_Date<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) and 
		  ((@Status_Code is null) or (Status_Code = @Status_Code)) and
		  ((ad.Assessment_ID = @Assessment_ID) or ad.Assessment_ID is null )
		  --and [asn].Applicant_ID<2000
                  
order by Last_Name, First_Name
	
--for xml auto
GO
