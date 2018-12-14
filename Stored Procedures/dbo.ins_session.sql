SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





/****** Object:  Stored Procedure dbo.ins_session    Script Date: 10/13/2004 3:22:52 PM ******/
CREATE        PROCEDURE [dbo].[ins_session]
    (
      @Applicant_ID INT ,
      @Position_ID TINYINT ,
      @Test_ID TINYINT ,
      @Location_ID INT 
    )
AS 
    SET nocount ON
    BEGIN
        DECLARE @sid INT
-- could be adding a secondary session for someone reapplying
        IF EXISTS ( SELECT  *
                    FROM    dbo.Applicant_Sessions
                    WHERE   Applicant_ID = @Applicant_ID
                            AND Assessment_ID = @Position_ID ) 
            SELECT  @sid = MAX(Session_ID)
            FROM    dbo.Applicant_Sessions
            WHERE   Applicant_ID = @Applicant_ID
                    AND Assessment_ID = @Position_ID
        ELSE 
            SELECT  @sid = 0
        SELECT  @sid = @sid + 1	
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
        IF EXISTS ( SELECT  *
                    FROM    dbo.Applicant_Sessions
                    WHERE   Applicant_ID = @Applicant_ID
                            AND Assessment_ID = @Position_ID ) 
            UPDATE  dbo.Applicant_Sessions
            SET     Status_Code = '1'
            WHERE   Applicant_ID = @Applicant_ID
                    AND Assessment_ID = @Position_ID
        SELECT  's00q000' AS bmk ,
                @sid AS sid ,
                -1 AS Section_Time ,
                @Location_ID AS Location_ID
        SET nocount OFF
    END





GO
