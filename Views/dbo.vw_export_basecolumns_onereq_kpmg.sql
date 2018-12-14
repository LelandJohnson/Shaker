SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_export_basecolumns_onereq_kpmg] 
AS
SELECT     ap.Applicant_ID AS aid, asn.Assessment_ID AS TestID, asn.Session_ID AS s, ad.Requisition_ID AS r, ap.First_Name AS fn, ap.Last_Name AS ln, ap.Login_ID AS id, 
                      ap.Employee_ID AS emp, ap.Other_ID AS id2, asn.Status_Code AS SC, CONVERT(nvarchar(100), asn.Start_Date, 20) AS SDate, CONVERT(nvarchar(100), 
                      asn.Applicant_Start_Date, 20) AS ASDate, CONVERT(nvarchar(100), asn.Last_Activity_Date, 20) AS ActivDate, CONVERT(nvarchar(100), asn.Completion_Date, 20) 
                      AS CDate, asn.Elapsed_Time AS ttime, asn.Question_Time AS qtime, asn.Results_Overall AS Score, asn.Scoring_Version AS scorever, asn.Content_Version AS cv, 
                      asn.Language_Code AS lang, asn.Alt_Version AS altver, MAX(CASE WHEN (Item_ID = 1) THEN (Item_Value) ELSE '' END) AS d1, MAX(CASE WHEN (Item_ID = 2) 
                      THEN (Item_Value) ELSE '' END) AS d2, MAX(CASE WHEN (Item_ID = 3) THEN (Item_Value) ELSE '' END) AS d3, MAX(CASE WHEN (Item_ID = 4) THEN (Item_Value) 
                      ELSE '' END) AS d4, MAX(CASE WHEN (Item_ID = 5) THEN (Item_Value) ELSE '' END) AS d5, MAX(CASE WHEN (Item_ID = 6) THEN (Item_Value) ELSE '' END) AS d6, 
                      MAX(CASE WHEN (Item_ID = 7) THEN (Item_Value) ELSE '' END) AS d7, MAX(CASE WHEN (Item_ID = 8) THEN (Item_Value) ELSE '' END) AS d8, 
                      MAX(CASE WHEN (Item_ID = 9) THEN (Item_Value) ELSE '' END) AS d9, MAX(CASE WHEN (Item_ID = 10) THEN (Item_Value) ELSE '' END) AS d10, 
                      MAX(CASE WHEN (Item_ID = 11) THEN (Item_Value) ELSE '' END) AS d11, MAX(CASE WHEN (Item_ID = 12) THEN (Item_Value) ELSE '' END) AS d12, 
                      MAX(CASE WHEN (Item_ID = 13) THEN (Item_Value) ELSE '' END) AS d13, MAX(CASE WHEN (Item_ID = 14) THEN (Item_Value) ELSE '' END) AS d14, 
                      MAX(CASE WHEN (Item_ID = 15) THEN (Item_Value) ELSE '' END) AS d15, MAX(CASE WHEN (Item_ID = 16) THEN (Item_Value) ELSE '' END) AS d16, 
                      MAX(CASE WHEN (Item_ID = 17) THEN (Item_Value) ELSE '' END) AS d17, MAX(CASE WHEN (Item_ID = 18) THEN (Item_Value) ELSE '' END) AS d18, 
                      MAX(CASE WHEN (Item_ID = 19) THEN (Item_Value) ELSE '' END) AS d19, MAX(CASE WHEN (Item_ID = 20) THEN (Item_Value) ELSE '' END) AS d20, 
                      MAX(CASE WHEN (Item_ID = 21) THEN (Item_Value) ELSE '' END) AS d21, MAX(CASE WHEN (Item_ID = 22) THEN (Item_Value) ELSE '' END) AS d22, 
                      MAX(CASE WHEN (Item_ID = 23) THEN (Item_Value) ELSE '' END) AS d23, MAX(CASE WHEN (Item_ID = 24) THEN (Item_Value) ELSE '' END) AS d24, 
                      MAX(CASE WHEN (Item_ID = 25) THEN (Item_Value) ELSE '' END) AS d25, MAX(CASE WHEN (Item_ID = 26) THEN (Item_Value) ELSE '' END) AS d26, 
                      MAX(CASE WHEN (Item_ID = 27) THEN (Item_Value) ELSE '' END) AS d27, MAX(CASE WHEN (Item_ID = 28) THEN (Item_Value) ELSE '' END) AS d28, 
                      MAX(CASE WHEN (Item_ID = 29) THEN (Item_Value) ELSE '' END) AS d29, MAX(CASE WHEN (Item_ID = 30) THEN (Item_Value) ELSE '' END) AS d30, 
                      MAX(CASE WHEN (Item_ID = 31) THEN (Item_Value) ELSE '' END) AS d31, MAX(CASE WHEN (Item_ID = 32) THEN (Item_Value) ELSE '' END) AS d32
FROM         dbo.Applicants AS ap INNER JOIN
                      dbo.Applicant_Sessions AS asn ON ap.Applicant_ID = asn.Applicant_ID

--outer apply like a join but combine in applicant data just for 1 req, and that req in order of preference is the one with the Hired status, then
--the Offer Accepted status, then any other
OUTER APPLY         
					(SELECT     *      FROM    dbo.Applicant_Data        
								 WHERE    
								 asn.Applicant_ID = Applicant_Data.Applicant_ID AND 
								 asn.Session_ID = Applicant_Data.Session_ID AND 
								 Applicant_Data.Assessment_ID = asn.Assessment_ID and
								 Requisition_ID = 
									(select top 1 requisition_id from Applicant_Data where   --top 1 limits to one req
									     Applicant_ID=asn.Applicant_ID and 
									     Session_ID=asn.Session_ID and 
									     Assessment_ID=asn.Assessment_ID and Item_ID=2
									 ORDER BY
									 CASE item_value										 --item_value for item_id=2 is the kpmg hiring status
									  WHEN 'Hired' THEN 1									 
									  WHEN 'Offer Accepted' THEN 2
									  ELSE 3
									 END
									)
					) ad
																	 
																	 


                      
GROUP BY ap.Applicant_ID, ap.First_Name, ap.Last_Name, ap.Login_ID, ap.Employee_ID, ap.Other_ID, asn.Status_Code, asn.Assessment_ID, asn.Start_Date, 
                      asn.Completion_Date, asn.Session_ID, asn.Results_Overall, ad.Requisition_ID, asn.Applicant_Start_Date, asn.Last_Activity_Date, asn.Elapsed_Time, 
                      asn.Question_Time, asn.Scoring_Version, asn.Content_Version, asn.Language_Code, asn.Alt_Version


GO
