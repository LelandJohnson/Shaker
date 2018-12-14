SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get list of assessment names, titles, branding, and directories
-- History:		v1 new for directv
-- =============================================
CREATE PROCEDURE [dbo].[get_assessment_config]
    (@Assessment_ID tinyint
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Assessments.Assessment_Code, Assessments.Full_Title, Assessments.Short_Title, Branding.Logo, Branding.Style_Sheet, Branding.Color_Scheme, 
                      Branding.Web_Banner, Branding.Privacy_Version, Branding.Terms_Version, Configuration.RJP_Mode
FROM         Assessments LEFT OUTER JOIN
                      Configuration ON Assessments.Assessment_ID = Configuration.Assessment_ID LEFT OUTER JOIN
                      Branding ON Assessments.Branding_ID = Branding.Branding_ID
WHERE     (Assessments.Assessment_ID = @Assessment_ID)

END
GO
