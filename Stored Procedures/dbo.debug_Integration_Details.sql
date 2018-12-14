SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		js
-- Description:	get Integration_Details info for transact/req 
--				NOT FOR PRODUCTION RELEASE
-- History:		v1 to show XML passed by web services
-- =============================================
CREATE  PROCEDURE [dbo].[debug_Integration_Details]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Session_ID TINYINT ,
      @Integration_System TINYINT = 1 --default to system 1
	)
AS
    SET NOCOUNT ON;

    SELECT TOP 1
            Receipt_ID ,
            Applicant_ID ,
            External_ID ,
            Assessment_ID ,
            Session_ID ,
            Communication_Type ,
            Timestamp ,
            Success ,
            Return_Code ,
            External_Receipt_ID ,
            Data_Sent AS ds  ,
            Data_Received AS dr ,
            Integration_System
    FROM    dbo.Integration_Details
    WHERE   Applicant_ID = @Applicant_ID
            AND Assessment_ID = @Assessment_ID
            AND Session_ID = @Session_ID
            AND Integration_System = @Integration_System
    ORDER BY [Timestamp] DESC;

GO
