SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get list of assessments for db/assessment selection screen
--				if superuser, no admin_id passed in so return all
--				if admin_id supplied, show only assessments allowed via admin_assessments
--				  (a record of the admin-assessment pair will exist)
-- History:		v1 rollout
--				v2 fixed bug for vjt not showing up in superuser list if no local admins
--				v2.1 re-fixed bug for vjt not showing up in superuser list if no local admins (LEFT JOIN Admin_Assessments)
--				v3 fixed bug that displayed wrong totals (multiplied by # of admin_assessments entries)
--				   10/29/2012
--				   
-- =============================================
CREATE PROCEDURE [dbo].[get_assessment_list]
    (@Admin_ID varchar(50),
     @Database_ID varchar(50)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--temp table to determine access
--will contain a row for client admins' assessments,
--or a row per assessment for superusers


declare @MonthDate datetime
set @MonthDate = DATEADD(MM, -1,GETDATE())

DECLARE @AdminAccess TABLE 
(
  AssessmentID tinyint
)


if @Admin_ID is null
    insert into @AdminAccess (AssessmentID)
	select Assessments.Assessment_ID from Assessments
else
    insert into @AdminAccess (AssessmentID)
	select Assessments.Assessment_ID from Assessments inner join Admin_Assessments on Assessments.Assessment_ID=Admin_Assessments.Assessment_ID
				 and (Admin_Assessments.Admin_ID like @Admin_ID) 
				 

SELECT     @Database_ID as Database_ID, Assessments.Assessment_ID, Assessments.Assessment_Code, Assessments.Full_Title, Assessments.Short_Title, Dat.Logo, Configuration.[Status], 
                      CONVERT(nvarchar(100), Configuration.Status_ChangeDate, 20) AS Status_ChangeDate,
                       sum(case when Applicant_Sessions.Status_Code=2 then 1 else 0 end) AS Complete_Applicants, 
                       sum(case when Applicant_Sessions.Status_Code>-1 then 1 else 0 end) AS Total_Applicants, 
                       sum(case when DATEDIFF(day, Start_Date, @MonthDate) <= 0 then 1 else 0 end) AS Month_Applicants
                       
                       
FROM         Assessments  INNER JOIN
                      Applicant_Sessions ON Assessments.Assessment_ID = Applicant_Sessions.Assessment_ID inner JOIN
                      Configuration ON Assessments.Assessment_ID = Configuration.Assessment_ID inner JOIN
                      Branding AS Dat ON Assessments.Branding_ID = Dat.Branding_ID
                      inner join @AdminAccess aa on Assessments.Assessment_ID = aa.AssessmentID


group by Assessments.Assessment_ID, Assessments.Assessment_Code, Assessments.Full_Title, Assessments.Short_Title,
			 Dat.Logo, Configuration.[Status], Status_ChangeDate
			 
for xml auto, elements    
END
GO
