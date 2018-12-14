SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		js
-- Description:	get list of assessment names, titles, branding, and directories
--				including the TBE names of the assessments
-- History:		v1 new for AAA TBE integration
-- =============================================
CREATE PROCEDURE [dbo].[get_assessments_integration]
    (
      @active BIT = 1 ,
      @Integration_System TINYINT = 1
    )
AS
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT  a.Assessment_ID ,
                a.Assessment_Code ,
                a.Full_Title ,
                a.Short_Title ,
                b.Logo ,
                b.Style_Sheet ,
                b.Color_Scheme ,
                b.Web_Banner ,
                b.Privacy_Version ,
                b.Terms_Version ,
                c.RJP_Mode ,
                ai.Assessment_Package_ID ,
                c.Production_URL_Int ,
                c.Staging_URL_Int ,
                c.Production_Repost_URL ,
                c.Staging_Repost_URL ,
                ai.Assessment_Package_ID AS [Package_ID] ,
                isd.Error_Notification_Email
        FROM    Assessments AS a
                LEFT OUTER JOIN Configuration AS c ON a.Assessment_ID = c.Assessment_ID
                LEFT OUTER JOIN Branding AS b ON a.Branding_ID = b.Branding_ID
                JOIN Assessments_Integrations AS ai ON a.Assessment_ID = ai.Assessment_ID
                JOIN dbo.Integration_Setup_Details AS isd ON ai.Integration_ID = isd.Integration_ID
        WHERE   ai.Integration_ID = @Integration_System
                AND ( ai.Active = @active
                      OR @active IS NULL
                    );
    END;

GO
