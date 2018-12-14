SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[upd_exportrow] (  
	  @Applicant_ID int, 
      @Test_ID tinyint, 
	  @Session_ID tinyint,  
      @Export_ID varchar(99),
      @Scoring_Version REAL,
      @Data_Row varchar(MAX)
	)
AS 
begin
      IF EXISTS (select Export_ID from dbo.Export_Data 
               where Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Test_ID
				  and Session_ID = @Session_ID
				  and Export_ID = @Export_ID
				  and Scoring_Version = @Scoring_Version
				  )             
                  
				UPDATE [dbo].[Export_Data]
				   SET [Data_Row] = @Data_Row
				 WHERE Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Test_ID
				  and Session_ID = @Session_ID
				  and Export_ID = @Export_ID
				  and Scoring_Version = @Scoring_Version
                        
      ELSE
		INSERT INTO .[dbo].[Export_Data]
				   ([Applicant_ID]
				   ,Assessment_ID
				   ,[Session_ID]
				   ,[Export_ID],Scoring_Version
				   ,[Data_Row])
			 VALUES
				   (@Applicant_ID
				   ,@Test_ID
				   ,@Session_ID
				   ,@Export_ID,@Scoring_Version
				   ,@Data_Row)

end

GO
