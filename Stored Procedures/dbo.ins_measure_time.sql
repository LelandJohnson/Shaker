SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[ins_measure_time] (  
      @Session_ID tinyint,  
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Measure_Name varchar(30),
      @Response  smallint)
AS 
begin
set nocount on
DECLARE @Measure_ID smallint
SELECT @Measure_ID = Measure_ID FROM Measures WHERE Measure_Name = @Measure_Name  and Assessment_ID = @Assessment_ID
	--and content_version matches content version from applicant session, later.
      IF EXISTS (select * from dbo.Applicant_Measures_Num 
               where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Assessment_ID
                  and Measure_ID = @Measure_ID)             
                  

                  UPDATE  Applicant_Measures_Num 
                  SET [Value] = CAST([Value] as smallint)+ CAST(@Response as smallint)
                  where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Assessment_ID
                  and Measure_ID = @Measure_ID
                        
      ELSE
                  insert into dbo.Applicant_Measures_Num (Session_ID,Applicant_ID,Assessment_ID,Measure_ID,[Value])
                  values(@Session_ID,@Applicant_ID,@Assessment_ID,@Measure_ID,@Response)
end







GO
