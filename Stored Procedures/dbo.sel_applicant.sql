SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		jw
-- Description:	Retrieve applicant based on login id
--				usually integration passed id in url, or use to check if
--				a login id already exists on self-signup.
--				Use separate sp for login from a form with password
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant] (@login_id varchar(50))
AS 
SELECT Applicant_ID, Last_Name, First_Name from Applicants Where Login_ID like @login_id
GO
