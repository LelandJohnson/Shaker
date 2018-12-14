SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write record for integration post that was not processed
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[ins_integration_exception]
	
	(
	@Timestamp datetime,
	@Remote_IP varchar(40),
	@RawXML varchar(max)
	)
	
AS
--SET NOCOUNT ON --leave count on to return number of records written

INSERT INTO [dbo].[Integration_Exceptions]
           ([Timestamp]
           ,[Remote_IP]
           ,[Data_Received])
     VALUES
           (@Timestamp, @Remote_IP, @RawXML)

GO
