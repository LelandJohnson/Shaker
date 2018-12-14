SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Retrieve applicant table info in xml form
--				Pass in session date range, position info
--				Return xml records
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicants]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     Applicant_ID, Login_ID, Last_Name, First_Name, Middle_Initial, Email, Phone, Employee_ID
FROM         Applicants for xml auto

END
GO
