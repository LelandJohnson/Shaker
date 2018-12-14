SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE PROCEDURE [dbo].[sel_bookmark] (  
      @Applicant_ID int,
      @Assessment_ID tinyint, 
      @Session_ID tinyint)
AS 
begin

select [Bookmark], Section_Time_Remaining from Applicant_Sessions where
      Applicant_ID=@Applicant_ID and
      Assessment_ID=@Assessment_ID and
      Session_ID=@Session_ID


                  
end









GO
