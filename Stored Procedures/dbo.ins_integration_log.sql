SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write record for integration batch log that runs nightly/periodically
--				records can be used for monitoring and status
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[ins_integration_log]
    (
      @Post_Count INT = 0 ,
      @Post_Type VARCHAR(100)
    )
AS --SET NOCOUNT ON --leave count on to return number of records written

    INSERT  INTO [dbo].[Log_Integration_Batch]
            ( [Timestamp] ,
              [Post_Count] ,
              [Post_Type]
            )
    VALUES  ( GETDATE() ,
              @Post_Count ,
              @Post_Type
            );
GO
