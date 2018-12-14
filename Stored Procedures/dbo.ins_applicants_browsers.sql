SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE     PROCEDURE [dbo].[ins_applicants_browsers] (@Applicant_ID int, @Position_ID TINYINT,
						@ua varchar(500),
						@flashver varchar(50), 
						@AS_detect_ver varchar(50), 
						@popupblocker smallint,
						@scrn_height smallint,
						@scrn_width smallint,
						@scrn_availheight smallint,
						@scrn_availwidth smallint,
						@scrn_colorDepth smallint,
						@lastscreen varchar(10) )
AS 
set nocount on
begin
	insert into dbo.Applicant_Logins
	        (Applicant_ID ,
	          Assessment_ID ,
	          [Timestamp] ,
	          Bookmark_at_Login,
	          User_Agent ,
	          Flash_Version ,
	          System_Width ,
	          System_Height ,
	          Avail_Width ,
	          Avail_Height ,
	          Popup_OK
	        )
	VALUES  (@Applicant_ID,@Position_ID,
						DEFAULT, 
						@lastscreen,
						@ua,
						@flashver, 
						@scrn_width,
						@scrn_height,
						@scrn_availwidth,
						@scrn_availheight,
						@popupblocker)
set nocount off
end



GO
