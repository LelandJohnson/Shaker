SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get applicants matching find/search criteria (name, email, phone)
-- History:		v1
--				v1.1 added Score2
-- =============================================
CREATE PROCEDURE [dbo].[get_findapplicant_results]
	
	(
	@Assessment_ID tinyint = 1,
	@First_Name nvarchar(50),
	@Last_Name nvarchar(50),
	@Email varchar(75),
	@Phone varchar(20)
	
	)
	
AS
	SET NOCOUNT ON
	
SELECT     ap.Applicant_ID as aid, ap.First_Name, ap.Last_Name, ap.Login_ID, ap.Employee_ID, [asn].Status_Code as SC,
		 [asn].Assessment_ID as TestID, convert(nvarchar(100),[asn].[Start_Date],20) as SDate,
		 convert(nvarchar(100),[asn].Completion_Date,20) as CDate, [asn].Session_ID, [asn].Results_Overall as Score,  
					  [asn].Results_OtherValue1 as Score2,  
                      ad.Item_Value as Val , ad.Item_ID as ID
FROM         Applicants AS ap INNER JOIN
                      Applicant_Sessions AS [asn] ON ap.Applicant_ID = [asn].Applicant_ID LEFT JOIN
                      Applicant_Data AS ad ON asn.Applicant_ID = ad.Applicant_ID and asn.Session_ID = ad.Session_ID
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((ad.Assessment_ID = @Assessment_ID) or ad.Assessment_ID is null )
		  and (([ap].First_Name like @First_Name) or (@First_Name is null))
		  and (([ap].Last_Name like @Last_Name) or (@Last_Name is null))
		  and (([ap].Email like @Email) or (@Email is null))
		  and ((@Phone is null) or
		  (

REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(Phone, '+', '')
			, '.', '')
			, '-', '')
			, ' ', '')
			, ')', '')
            ,'(','')
             LIKE
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(@Phone, '+', '')
			, '.', '')
			, '-', '')
			, ' ', '')
			, ')', '')
            ,'(','')          		  
		  
		  ))
                  
order by [asn].Start_Date desc
	

for xml auto
GO
