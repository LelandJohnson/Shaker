SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
Status_Code VALUE="0" > Testing not started
            VALUE="1" > Testing incomplete 
            VALUE="2" > Testing complete 
*/
CREATE PROCEDURE [dbo].[sel_available_tests] (
     @Applicant_ID INT,
     @Position_ID TINYINT
    )
AS 
    SET NOCOUNT ON
    DECLARE @Elapsed_Days INT, @MaxCompSession INT
    
    SELECT @Elapsed_Days = DATEDIFF(day, (
                                    SELECT  MAX(Session_Date)
                                    FROM    test_er
                                    WHERE   [Applicant_ID] = @applicant_ID
                                            AND [Position_ID] = @Position_ID
                                            AND [Test_Status_Code] = 2
                                  ), GETDATE())
    SELECT @MaxCompSession = MAX(Session_ID) FROM test_er
                                    WHERE   [Applicant_ID] = @applicant_ID
                                            AND [Position_ID] = @Position_ID
                                            AND [Test_Status_Code] = 2
    
    DECLARE @testsTable TABLE (
         Position_ID TINYINT,
         Position_Code VARCHAR(50),
         Position_Name VARCHAR(200),
         Position_Desc VARCHAR(3000),
         Test_Name VARCHAR(50),
         Test_Desc VARCHAR(400),
         Test_Directory VARCHAR(50),
         Test_ID TINYINT,
         Session_Date DATETIME,
         Time_To_Reapply VARCHAR(50),
         Status_Code VARCHAR(50),
         Applicant_ID INT,
         Elapsed_Days INT
        )
    INSERT  INTO @testsTable (
             Position_ID,
             Position_Code,
             Position_Name,
             Position_Desc,
             Test_Name,
             Test_Desc,
             Test_Directory,
             Test_ID,
             Session_Date,
             Time_To_Reapply,
             Status_Code,
             Applicant_ID,
             Elapsed_Days
            )
            SELECT  p.Position_ID,
                    p.Position_Code,
                    p.Position_Name,
                    p.Position_Desc,
                    t.Test_Name,
                    t.Test_Desc,
                    t.Test_Directory,
                    t.Test_ID,
                    NULL AS Session_Date,
                    p.Time_To_Reapply,
                    ast.Status_Code,
                    ast.Applicant_ID,
                    NULL AS Elapsed_Days
            FROM    dbo.Applicant_Status ast
                    INNER JOIN dbo.Positions p ON ast.Position_ID = p.Position_ID
                    INNER JOIN dbo.Position_Test_Link ptl ON p.Position_ID = ptl.Position_ID
                    INNER JOIN dbo.Tests t ON ptl.Test_ID = t.Test_ID
            WHERE   ast.Applicant_ID = @Applicant_ID
                    AND ast.[Position_ID] = @Position_ID
                    AND ast.Status_Code IN ( '0', '1', '3' )
            UNION
            SELECT  p.Position_ID,
                    p.Position_Code,
                    p.Position_Name,
                    p.Position_Desc,
                    t.Test_Name,
                    t.Test_Desc,
                    t.Test_Directory,
                    t.Test_ID,
                    ter.Session_Date,
                    p.Time_To_Reapply,
                    ast.Status_Code,
                    ast.Applicant_ID,
                    @Elapsed_Days AS Elapsed_Days
            FROM    dbo.Applicant_Status ast
                    INNER JOIN dbo.Positions p ON ast.Position_ID = p.Position_ID
                    INNER JOIN dbo.Position_Test_Link ptl ON p.Position_ID = ptl.Position_ID
                    INNER JOIN dbo.Tests t ON ptl.Test_ID = t.Test_ID
                    INNER JOIN dbo.Test_ER ter ON ast.Applicant_ID = ter.Applicant_ID
                                                  AND ast.Position_ID = ter.Position_ID
                                                  AND t.Test_ID = ter.Test_ID
            WHERE   ast.Applicant_ID = @Applicant_ID
                    AND ast.[Position_ID] = @Position_ID
                    AND ast.Status_Code IN ( '2' )
                    AND p.Time_To_Reapply < @Elapsed_Days
                    AND ter.[Session_ID] = @MaxCompSession
            GROUP BY p.Position_ID,
                    p.Position_Code,
                    p.Position_Name,
                    p.Position_Desc,
                    t.Test_Name,
                    t.Test_Desc,
                    t.Test_Directory,
                    t.Test_ID,
                    p.Time_To_Reapply,
                    ast.Status_Code,
                    ast.Applicant_ID,
                    ter.Session_Date
    SELECT  *,
            COUNT(*) AS counter
    FROM    @testsTable
    GROUP BY Position_ID,
            Position_Code,
            Position_Name,
            Position_Desc,
            Test_Name,
            Test_Desc,
            Test_Directory,
            Test_ID,
            Session_Date,
            Time_To_Reapply,
            Status_Code,
            Applicant_ID,
            Elapsed_Days

GO
