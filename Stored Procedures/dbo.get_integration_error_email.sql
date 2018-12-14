SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		js
-- Description:	get error reporting email addresses for this Integration System
--				based on integration name.
-- History:		v1 6/2016
--				v1.1 5/17 removed Return statement since return must be an int for an ExecuteNonQuery call
-- =============================================
CREATE  PROCEDURE [dbo].[get_integration_error_email]
    (
      @Server_Application VARCHAR(64) ,
      @Error_Notification_Email VARCHAR(255) OUTPUT
    )
AS
    SET NOCOUNT ON;

    SELECT  @Error_Notification_Email = Error_Notification_Email
    FROM    dbo.Integration_Setup_Details
    WHERE   Server_Application = @Server_Application;

GO
