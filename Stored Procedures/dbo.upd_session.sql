SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




/****** Object:  Stored Procedure dbo.upd_session    Script Date: 10/13/2004 3:24:01 PM ******/
CREATE      PROCEDURE [dbo].[upd_session]
    (
      @Applicant_ID INT ,
      @Position_ID TINYINT ,
      @Test_ID TINYINT ,
      @Location_ID INT
    )
AS 
    IF ( SELECT MAX(Session_ID)
         FROM   dbo.Applicant_Sessions
         WHERE  Applicant_ID = @Applicant_ID
                AND Assessment_ID = @Position_ID
       ) IS NULL 
        BEGIN
            DECLARE @sid TINYINT
            SELECT  @sid = 1	
            PRINT 'adding test_er'
            INSERT  INTO dbo.Applicant_Sessions
                    ( Session_ID ,
                      Applicant_ID ,
                      Assessment_ID ,
                      Location_ID ,
                      Start_Date ,
                      Elapsed_Time ,
                      Status_Code ,
                      Section_Time_Remaining
                    )
            VALUES  ( @sid ,
                      @Applicant_ID ,
                      @Position_ID ,
                      @Location_ID ,
                      GETDATE() ,
                      0 ,
                      1 ,
                      -1
                    )
            SELECT  's00q000' AS bmk ,
                    @sid AS sid ,
                    -1 AS Section_Time ,
                    @Location_ID AS Location_ID
        END
    ELSE 
        SELECT  MAX(Session_ID) AS sid ,
                Bookmark AS bmk ,
                Section_Time_Remaining AS Section_Time ,
                Location_ID
        FROM    dbo.Applicant_Sessions
        WHERE   Applicant_ID = @Applicant_ID
                AND Assessment_ID = @Position_ID
        GROUP BY Bookmark ,
                Section_Time_Remaining ,
                Location_ID


GO
