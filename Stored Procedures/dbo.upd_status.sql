SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		jw
-- Description:	update applicant status
--				usually when entering vjt setting to in-progress.
-- History:		v1 roll out
--
--				v2 added support for updating Alt_Version (such as text-only variation)
-- =============================================
CREATE      PROCEDURE [dbo].[upd_status]
    (
	  @Session_ID TINYINT,
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Status_Code INT,
      @Alt_Version TINYINT = null  --optional alt version number
    )
AS 
UPDATE [dbo].[Applicant_Sessions]
   SET [Last_Activity_Date] = getdate(),
       [Status_Code] = @Status_Code,
       [Alt_Version] = @Alt_Version

 WHERE 
 [Applicant_ID] = @Applicant_ID and
 [Assessment_ID] = @Assessment_ID and
 [Session_ID] = @Session_ID
 and Status_Code<>2 --do not set back to 1 if already 2
 
GO
