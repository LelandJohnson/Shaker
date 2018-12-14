SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Look up applicant reset question (by number)
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant_resetq]
    (@Applicant_ID as integer
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT Password_ResetQ
 from Applicants
 where Applicant_ID = @Applicant_ID

END
GO
