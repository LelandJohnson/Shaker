SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	Try to log in admin
--				Pass in admin id and pw hash
--				Return success, policies, account status, and permissions
--				if wrong password, process attempts and lockout
-- History:		v1
--
--				v2 added client db permissions, so no longer the same as mcp copy of get_admin_login
--
-- Sync:		Different between MCP database and each customer db
--
-- =============================================
CREATE PROCEDURE [dbo].[get_admin_login]
    (@Admin_ID as varchar(50),
     @Password as varchar(64)
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

declare @Fails tinyint
declare @MaxFails tinyint
declare @LockTime datetime

SELECT     Administrators.First_Name, Administrators.Last_Name, [Email], Administrators.Initials, Administrators.Active, Administrators.Last_Login_Date, Administrators.Password_Date, 
                      Administrators.Consecutive_Fails, Administrators.Locked_Until_Date, Policies.Max_Account_Inactivity, DATEDIFF(n, GETDATE(), Administrators.Locked_Until_Date) 
                      AS AccountLocked, DATEADD(d, Policies.Max_Password_Age, Administrators.Password_Date) AS Password_Expiration_Date, DATEDIFF(d, 
                      Administrators.Last_Login_Date, GETDATE()) AS Days_Inactive, Policies.Max_Session_Inactivity, Policies.Max_Session_Length, 
                      COUNT(Admin_Assessments.Assessment_ID) AS AssessmentCount,
                      
                      --build own xml string to combine from two places
                      '<Perms>' + --opening tag
                      cast((
                      --permissions granted by admin's security level
						SELECT     Security_Level_Permissions.Permission_ID '@ID', Security_Level_Permissions.Granted '@Granted'
						FROM         Admin_Security_Levels INNER JOIN
											  Security_Level_Permissions ON Admin_Security_Levels.Sec_Level_ID = Security_Level_Permissions.Sec_Level_ID
						WHERE     (Admin_Security_Levels.Admin_ID LIKE @Admin_ID) AND (Security_Level_Permissions.Granted = 1)

						for XML PATH('Permission'),   TYPE
					   ) as varchar(4000))
					   +
					   cast((
						--then full list of grant+deny overrides
						SELECT Permission_ID '@ID', Granted '@Granted' from Admin_Permissions where Admin_ID like @Admin_ID                      
						--will be processed in order so overrides will add/remove defaults
						
                      for XML PATH('Permission'),  TYPE
                      ) as varchar(4000)) 
                      + '</Perms>' --closing tag
                       as PermXML
                       
FROM         Administrators LEFT OUTER JOIN
                      Admin_Assessments ON Administrators.Admin_ID = Admin_Assessments.Admin_ID CROSS JOIN
                      Policies
WHERE     (Administrators.Admin_ID LIKE @Admin_ID)
  and [Password] = @Password
  and Active = 1
group by First_Name, Last_Name, Email, Initials, Active, Last_Login_Date, Password_Date, Consecutive_Fails, Locked_Until_Date, Max_Account_Inactivity, Max_Password_Age,
		Max_Session_Inactivity, Max_Session_Length


if @@rowcount=0 
  begin
 
   --log failure
   --reset failure count
	update Administrators set Consecutive_Fails = Consecutive_Fails+1 
	Where Admin_ID like @Admin_ID;
    
		--see if account locked
		SELECT    @Fails=Consecutive_Fails, @MaxFails=Max_Consecutive_Fails
		FROM     Administrators cross join Policies
		Where Admin_ID like @Admin_ID  and
		      Policies.Selected_Policy = 1;
		
		if (@MaxFails>0) and (@Fails > @MaxFails)
         begin
			--lock account
			set @LockTime = DATEADD(n, 30, GetDate())
			update Administrators set Locked_Until_Date=@LockTime
			Where Admin_ID like @Admin_ID  
         end

  end
else
  begin
   --login+pw match
   --reset failure count
	update Administrators set Consecutive_Fails = 0
	Where Admin_ID like @Admin_ID 
	
   --clear locked date if past date
   update Administrators set Locked_Until_Date = null
    where Admin_ID like @Admin_ID and
    DATEDIFF("n", Locked_Until_Date, GetDate()) > 0
    
   
      
   	
	  
  end

	
    
END
GO
