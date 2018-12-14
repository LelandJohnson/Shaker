SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Try to log in applicant
--				Pass in applicant id and pw hash
--				Return matching applicant record or nothing
-- History:		v1
--
--
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant_passwordcheck]
    (@Applicant_ID as int,
     @Password as varchar(64)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Applicants.Applicant_ID from Applicants
	 where Applicant_ID = @Applicant_ID and
	 [Password] = @Password;
	
    
END
GO
