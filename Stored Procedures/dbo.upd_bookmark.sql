SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	updated by newsubmit.asp with new 
-- History:		v1 new bookmark update that also updates last activity date
--
--				v2 added applicant_start_date info, updated if not already created.
--				   also calling upd_bookmark now even with null bookmark, so don't update
--				   question time or bookmark if no bookmark.
-- =============================================
CREATE PROCEDURE [dbo].[upd_bookmark] (      
      @Session_ID tinyint,  
      @Applicant_ID int, 
      @Assessment_ID tinyint, 
      @Last_Screen varchar(9),
      @Question_Time  int,
      @Elapsed_Time int)
AS 

  if @Last_Screen is null 
                  --not answering real question (like kbps or feedback)
                  UPDATE  Applicant_Sessions 
                  SET  
                  Elapsed_Time = CAST(Elapsed_Time as int) + CAST(@Elapsed_Time as int),
                  Last_Activity_Date = GETDATE(), Applicant_Start_Date = ISNULL(Applicant_Start_Date, GETDATE())
                  where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Assessment_ID

  else
  
                  UPDATE  Applicant_Sessions 
                  SET  Question_Time = CAST(Question_Time as int) + CAST(@Question_Time as int),
                  Elapsed_Time = CAST(Elapsed_Time as int) + CAST(@Elapsed_Time as int),
                  Bookmark = @Last_Screen,
                  Last_Activity_Date = GETDATE(), Applicant_Start_Date = ISNULL(Applicant_Start_Date, GETDATE())
                  where Session_ID = @Session_ID
                  and Applicant_ID = @Applicant_ID
                  and Assessment_ID = @Assessment_ID
  
  
GO
