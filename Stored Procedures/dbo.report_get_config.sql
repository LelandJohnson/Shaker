SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get variables to drive common reports
-- History:		v1 rollout
--				   
-- =============================================
CREATE PROCEDURE [dbo].[report_get_config]
    (@Assessment_ID tinyint,
     @Report_ID varchar(50),
	 @Report_Variable VARCHAR(50) = NULL  --optional, if omitted returns all vars
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT Report_Variable, [Value] FROM dbo.Report_Configuration
 WHERE Assessment_ID=@Assessment_ID
  AND Report_ID LIKE @Report_ID 
  AND Report_Variable LIKE ISNULL(@Report_Variable, '%')



END
GO
