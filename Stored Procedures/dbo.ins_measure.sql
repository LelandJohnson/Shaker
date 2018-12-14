SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/*
	ins_measure
	v2 - supporting Cumulative flag in measures table
	v3 - cap number Response at maxint and limit cumulative totals at maxint
*/
CREATE PROCEDURE [dbo].[ins_measure] (  
      @Session_ID tinyint,  
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Measure_Name varchar(50),
      @Response  varchar(4000))
AS 

begin
set nocount on
DECLARE @Measure_ID smallint, @Textual as bit, @Cumulative as bit

DECLARE @Smallint_Response SMALLINT
DECLARE @Smallint_Total SMALLINT




SELECT @Measure_ID = Measure_ID, @Textual = Textual, @Cumulative = ISNULL(Cumulative, 0) FROM Measures
 WHERE Measure_Name = @Measure_Name  and Assessment_ID = @Assessment_ID
--and content_version matches content version from applicant session, later.
--(see all ins_measure_time) 

IF (@Textual=1) --true
 BEGIN
 print @Textual
 
	  --check if exists, for update vs insert
      IF EXISTS (select Value from dbo.Applicant_Measures_Text
               where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Assessment_ID
                  and Measure_ID = @Measure_ID)
                  
                  
                  UPDATE  Applicant_Measures_Text 
                  SET [Value] = @Response
                  where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
				  and Assessment_ID = @Assessment_ID
				  and Measure_ID = @Measure_ID
                        
      ELSE
		
		
                  insert into dbo.Applicant_Measures_Text (Session_ID,Applicant_ID,Assessment_ID,Measure_ID,[Value])
                  values(@Session_ID,@Applicant_ID,@Assessment_ID,@Measure_ID,@Response)

		
 
 END
ELSE --numeric
	BEGIN
		--new response capping coming in, numeric only
		SET @Response = ISNULL(@Response,0) --nulls to 0 for numeric

		IF CAST(@Response AS INT) >= 32766
		   SET @Smallint_Response = 32766
		ELSE
		   SET @Smallint_Response = CAST(@Response AS SMALLINT)

 
			  --check if exists, for update vs insert
			  IF EXISTS (select Value from dbo.Applicant_Measures_Num 
					   where Session_ID = @Session_ID
						  and Applicant_ID = @Applicant_ID
						  and Assessment_ID = @Assessment_ID
						  and Measure_ID = @Measure_ID)
                  
                  
						  UPDATE  Applicant_Measures_Num 
						  SET [Value] =
							CASE when @Cumulative = 1 THEN			--add to previous value
							 --first verify new total is still smallint
							 --(do math with int in case of overflow just doing check)
								 CASE WHEN CAST([Value] AS INT)+@Smallint_Response < 32766 THEN
									[Value] + @Smallint_Response
								 ELSE
									32766                       
								 END                   


							ELSE  
							 @Smallint_Response
							END
						  where Session_ID = @Session_ID
						  and Applicant_ID = @Applicant_ID
						  and Assessment_ID = @Assessment_ID
						  and Measure_ID = @Measure_ID
				  
                        
			  ELSE
						  insert into dbo.Applicant_Measures_Num (Session_ID,Applicant_ID,Assessment_ID,Measure_ID,[Value])
						  values(@Session_ID,@Applicant_ID,@Assessment_ID,@Measure_ID, @Smallint_Response)
                  
                  
	END   
  
end 
 
 







GO
