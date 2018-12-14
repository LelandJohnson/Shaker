SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- =============================================
-- Author:		jw
-- Description:	Retrieve active session number and status
--				for applicant's assessment. 
--				Creates new session if it does not exist.
--				Status code initially 0, so set to 1=in progress upon launch.
-- History:		v0.8
--				Rolling out without code to create 2nd session and beyond.
--				If status code is 2 (complete) it just sits there on the
--				completed session 1.  next versions (v1.00+) will include retake policy
--				and incomplete session expiration to create session 2 and beyond.
--
--				v0.9
--				Added First & Last name, section time and vjt path retrival
--
--				v0.95 (still no session #2)
--					  add optional param for default language
--			
--				v0.96 added support for Alt_Version (such as text-only variation)
--
--				v1.00 will create and return 2nd+ session number based on 
--					  assessments table Retake_Policy_Months
--					  and Restart_Policy_Months (if any)
--
--				v1.01 set new sessions to default language passed in, if any
--				v2	  for session 2 eligibility check, uses applicant_sessions' retake_date if available,
--					  otherwise computes based on retake policy like before.
--
--				v2.01 added OtherData to returned recordset for html5 compat
-- =============================================
CREATE   PROCEDURE [dbo].[get_session]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
	  @DefaultLang VARCHAR(24) = null     
    )
AS 
    SET nocount ON
    BEGIN
        DECLARE @sid tinyint
        declare @status smallint
        declare @neednew bit
        declare @Start_Date datetime
        declare @Completion_Date datetime
        declare @Bookmark varchar(9)
        declare @Section_Time_Remaining smallint
		
		declare @Retake_Date datetime
		
		declare @Path varchar(50)
		declare @Last_Name varchar(50)
		declare @First_Name varchar(50)
        
        declare @Lang varchar(24)
		declare @Alt_Version tinyint
		        
        SELECT  @sid = 0    --default no session in db
        select @neednew = 1 --need new session


-- always get applicant name and vjt folder
      SELECT     @Last_Name = Applicants.Last_Name, @First_Name = Applicants.First_Name, @Path = Assessments.Assessment_Code
		FROM         Applicants CROSS JOIN
							  Assessments
		WHERE     (Assessments.Assessment_ID = @Assessment_ID) AND (Applicants.Applicant_ID = @Applicant_ID)
--	later this assessments folder info can be retrieved along with branding info when this page is made
--  generic, as it is kind of a stretch to cross join that info in with applicant session info.
        

        
-- retrieve latest session_id if any into @sid, or @sid=0 if none
        IF EXISTS ( SELECT  *
                    FROM    dbo.Applicant_Sessions
                    WHERE   Applicant_ID = @Applicant_ID
                            AND Assessment_ID = @Assessment_ID ) 
          begin
            SELECT  @sid = MAX(Session_ID)  --highest session number = latest
            FROM    dbo.Applicant_Sessions
            WHERE   Applicant_ID = @Applicant_ID
                    AND Assessment_ID = @Assessment_ID
                    
			select @status = [Status_Code], @Start_Date = [Start_Date], @Completion_Date = [Completion_Date],
					@Bookmark = Bookmark, @Section_Time_Remaining = Section_Time_Remaining, @Lang = Language_Code, @Alt_Version = Alt_Version,
					@Retake_Date = Retake_Date
			    --status code etc for latest session
            FROM    dbo.Applicant_Sessions
            WHERE   Applicant_ID = @Applicant_ID
                    AND Assessment_ID = @Assessment_ID
                    
			select @neednew = 0 --don't need new session
			                    
				--if status code complete, check against valid date range
				--to see if new session needs to be created

				if @status = 2
				  begin
						--time since test is current date - completion date
						--compare to assessments table Retake_Policy_Months
						
						--just month difference doesn't care what day in the month it is.
						--have to compare tiny difference between now and the date+time allowed
						--back in. (completion date + retake months)
						--(using days, can retake n months from the day they finished)
						
						
							--new: if retake date already computed (applicant_sessions) use it,
							--otherwise compute it based on retake policy
							--(implemented in ISNULL function below,
							-- which is the date1 parameter of the DateDiff function)
						
						select @neednew=
						 case when (DATEDIFF(D,
											ISNULL(@Retake_Date,
										 	 (dateadd(M,Assessments.Retake_Policy_Months,@Completion_Date))
										 	      ),
									         GETDATE()
									         ) >= 0)
								then 1
						 else 0
						end 
						 from Assessments
						where assessment_id = @Assessment_ID
						
						--still valid score, just
						--keep existing session and report
						--back status code of 2 for complete
						
						 
				  end				                    
				
				if @status = 1
				  begin
						--also compare start date to restart policy
						--may need to create new session
						--leaving previous session incomplete.
						select @neednew=
						 case when (DATEDIFF(D, (dateadd(M,Assessments.Restart_Policy_Months,@Start_Date)), GETDATE()) >= 0)
								then 1
						end 
						 from Assessments
						where assessment_id = @Assessment_ID
												
				  end                    
                    
                    
		  end	
			--pull current content ver from
			--configuration or assessment info later
                    
        if @neednew = 1 
			--no sessions existed for applicant, or enough time since prev session
		    BEGIN
		    
		    
		    select @status = 0 --intial status code, 0 not started
		    select @Bookmark = ''
		    select @Section_Time_Remaining = -1
		    select @Lang = @DefaultLang --default null = en-US
		    select @Alt_Version = null --default standard version
		    
		    --create a session 1
				SELECT  @sid = @sid + 1	--was 0 or prev complete old session
				
				INSERT  INTO dbo.Applicant_Sessions
						( Applicant_ID ,
						  Assessment_ID ,
						  Session_ID ,
						  Content_Version ,
						  [Start_Date] ,
						  Elapsed_Time ,
						  Question_Time,
						  Status_Code ,
						  Section_Time_Remaining,
						  Language_Code
						  
						)
				VALUES  ( 
						  @Applicant_ID ,
						  @Assessment_ID ,
						  @sid ,
						  1 ,
						  GETDATE() ,
						  0 ,
						  0 ,
						  @status ,
						  -1,
						  @DefaultLang
						)
				    
		    
		    END
		            
            
     select @sid as [Session_ID], @status as [Status_Code], @Bookmark as [Bookmark], @Section_Time_Remaining as [Section_Time_Remaining],
			@Last_Name as [Last_Name], @First_Name as [First_Name], @Path as [Path], @Lang as [Language_Code], @Alt_Version as [Alt_Version], NULL AS [OtherData]
		
    END





GO
