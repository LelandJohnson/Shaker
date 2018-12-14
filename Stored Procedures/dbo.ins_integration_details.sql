SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write record for integration transactions back and forth
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[ins_integration_details]
	
	(
	@Applicant_ID int,
    @External_ID varchar(25),
    @Assessment_ID tinyint,
    @Session_ID tinyint,
    @Communication_Type varchar(50),
    @Timestamp datetime,
    @Success bit,
    @Return_Code varchar(50),
    @External_Receipt_ID varchar(50),
    @Data_Sent varchar(max),
    @Data_Received varchar(max),
    @Integration_System tinyint = 1
	)
AS
--SET NOCOUNT ON --leave count on to return number of records written

INSERT INTO [dbo].[Integration_Details]
           ([Applicant_ID]
           ,[External_ID]
           ,[Assessment_ID]
           ,[Session_ID]
           ,[Communication_Type]
           ,[Timestamp]
           ,[Success]
           ,[Return_Code]
           ,[External_Receipt_ID]
           ,[Data_Sent]
           ,[Data_Received]
           ,[Integration_System])
     VALUES
           (
	@Applicant_ID,
    @External_ID,
    @Assessment_ID,
    @Session_ID,
    @Communication_Type,
    @Timestamp,
    @Success,
    @Return_Code,
    @External_Receipt_ID,
    @Data_Sent,
    @Data_Received,
    @Integration_System
           )
GO
