SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		jw
-- Description:	retrieve the list of dimensions to record
-- History:		v1
-- =============================================
CREATE                 PROCEDURE [dbo].[get_dimensions]
    (
		@Assessment_ID tinyint,
		@Scoring_Version real
    )
AS 
set nocount on

 select Dimension_ID, SPSS_Variable, Is_Overall, Is_OtherOverall1, Is_OtherOverall2  from Dimensions
 where Assessment_ID = @Assessment_ID and Scoring_Version = @Scoring_Version
 order by Dimension_ID;
 

GO
