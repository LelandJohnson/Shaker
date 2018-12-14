SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	get applicant info about person and session
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_session_info_classic]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT = 1 ,
      @Session_ID TINYINT
	
    )
AS 
    SET NOCOUNT ON
	
    SELECT  ap.Applicant_ID ,
            ap.Login_ID ,
            ap.Last_Name ,
            ap.First_Name ,
            ap.Middle_Initial ,
            ap.Email ,
            ap.Phone ,
            ap.Employee_ID ,
            asn.Assessment_ID ,
            asn.Session_ID ,
            asn.Content_Version ,
            CONVERT(NVARCHAR(100), asn.Start_Date, 20) AS Start_Date ,
            CONVERT(NVARCHAR(100), asn.Completion_Date, 20) AS Completion_Date ,
            CONVERT(NVARCHAR(100), asn.Last_Activity_Date, 20) AS Last_Activity_Date ,
            a.Restart_Policy_Months,
            a.Retake_Policy_Months,
            asn.Elapsed_Time ,
            asn.Question_Time ,
            asn.Scoring_Version ,
            asn.Classification_ID ,
            asn.Status_Code ,
            asn.Integration_Flag ,
            asn.Section_Time_Remaining ,
            asn.Bookmark ,
            asn.Results_Overall ,
            asn.Results_OtherValue1 ,
            asn.Results_OtherValue2 ,
            asn.Language_Code ,
            asn.Alt_Version ,
            ad.Item_ID ,
            ad.Item_Value
    FROM    Applicants AS ap
            INNER JOIN Applicant_Sessions AS asn ON ap.Applicant_ID = asn.Applicant_ID
            JOIN dbo.Assessments a ON asn.Assessment_ID = a.Assessment_ID
            LEFT OUTER JOIN Applicant_Data AS ad ON ( asn.Applicant_ID = ad.Applicant_ID )
                                                    AND ( asn.Session_ID = ad.Session_ID )
    WHERE   ( asn.Assessment_ID = @Assessment_ID )
            AND ( asn.Applicant_ID = @Applicant_ID )
            AND ( asn.Session_ID = @Session_ID )
            AND ( ad.Assessment_ID = @Assessment_ID
                  OR ad.Assessment_ID IS NULL
                )
            AND ( ad.Session_ID = @Session_ID
                  OR ad.Session_ID IS NULL
                )
    ORDER BY ad.Item_ID



GO
