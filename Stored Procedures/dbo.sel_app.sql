SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE  PROCEDURE [dbo].[sel_app] ( @login_id VARCHAR(50), @Position_ID TINYINT )
AS 
DECLARE @aid INT
SET @aid = (SELECT TOP 1 applicant_ID FROM dbo.Applicants WHERE Login_ID = @login_id)
    SELECT  Applicants.Applicant_ID ,
            Applicants.Login_ID ,
            Applicants.Last_Name ,
            Applicants.First_Name ,
            Applicants.Middle_Initial ,
            Applicants.Email ,
            Applicants.Phone ,
            Applicants.Employee_ID ,
            Applicants.Password ,
            Applicants.Password_ResetQ ,
            Applicants.Password_ResetA ,
            Applicants.Password_Hint,
            (SELECT item_value FROM dbo.Applicant_Data WHERE Item_ID = 1 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS Function_ID,
            (SELECT item_value FROM dbo.Applicant_Data WHERE Item_ID = 2 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS PositionBio,
            (SELECT CAST(item_value AS INT)/12 FROM dbo.Applicant_Data WHERE Item_ID = 3 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS TenureRoleY,
            (SELECT CAST(item_value AS INT)%12 FROM dbo.Applicant_Data WHERE Item_ID = 3 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS TenureRoleM,
            (SELECT CAST(item_value AS INT)/12 FROM dbo.Applicant_Data WHERE Item_ID = 4 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS TenureCareerY,
            (SELECT CAST(item_value AS INT)%12 FROM dbo.Applicant_Data WHERE Item_ID = 4 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS TenureCareerM,
            (SELECT item_value FROM dbo.Applicant_Data WHERE Item_ID = 5 AND Assessment_ID  = @Position_ID AND Applicant_ID = @aid) AS Location_ID
    FROM    Applicants
    WHERE   Login_ID LIKE @login_id


GO
