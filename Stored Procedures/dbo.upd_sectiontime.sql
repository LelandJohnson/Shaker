SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO


Create PROCEDURE [dbo].[upd_sectiontime] (	
	@Session_ID tinyint,
	@Applicant_ID int, 
	@Assessment_ID tinyint, 
	@Section_Time  int)
AS 
			
			UPDATE  Applicant_Sessions 
			SET Section_Time_Remaining =  @Section_Time 
			where Session_ID = @Session_ID
			and Applicant_ID = @Applicant_ID
			and Assessment_ID = @Assessment_ID
GO
