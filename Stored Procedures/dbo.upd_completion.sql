SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	if not already complete, mark complete
-- History:		v1
--				v2 added optional @Months_Valid.
--				   if supplied, set retake date to completion_date + @Months_Valid
--				   (relies on applicant_session new retake_date field)
--
-- =============================================
CREATE PROCEDURE [dbo].[upd_completion] (  
      @Applicant_ID int,
      @Assessment_ID tinyint, 
      @Session_ID tinyint,
      @Months_Valid tinyint = null
      )
AS 
begin

set nocount off --need count to return rows affected

declare @ValidTo_Date smalldatetime
if @Months_Valid is null
	set @ValidTo_Date = null
else
	set @ValidTo_Date = DATEADD(MM,@Months_Valid, getdate())


UPDATE [dbo].[Applicant_Sessions]
   SET [Completion_Date] = GETDATE(),
       [Status_Code] = 2,
       [Retake_Date] = ISNULL(@ValidTo_Date, null )
 WHERE [Applicant_ID] = @Applicant_ID and
       [Assessment_ID] = @Assessment_ID and
       [Session_ID] = @Session_ID and
       [Status_Code] <> 2
   
                  
end

GO
