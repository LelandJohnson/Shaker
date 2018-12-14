SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	xmlrpt_CandidateFormLetter_KPMG
--				report data for CandidateFormLetter_KPMG report
--				retrieve applicant first, last name, dates,
--				xml for 2nd payload with req info, and motiv/strength xml
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[xmlrpt_CandidateFormLetter_KPMG]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
	@Req varchar(50)
	)
	
AS
declare @xmlBuild  varchar(max)
declare @xmlParse xml

declare @FN varchar(50)
declare @LN varchar(50)
declare @date1 datetime
declare @date2 datetime

declare @rptscores varchar(2048)

SET NOCOUNT ON

--latest aor req xml

select top (1) @xmlBuild = Data_Sent
FROM         Integration_Details
WHERE     (Applicant_ID = @Applicant_ID) AND (Assessment_ID = @Assessment_ID) AND (Session_ID = @Session_ID) AND
 (Communication_Type like 'AOR') and
 (Data_Sent LIKE '%<BRREQNUMBER>' + @Req + '</BRREQNUMBER>%')
ORDER BY Timestamp DESC 


--names and dates

SELECT     @FN = Applicants.First_Name, @LN = Applicants.Last_Name, @date1 = Applicant_Sessions.[Start_Date], 
                      @date2 = Applicant_Sessions.Completion_Date
FROM         Applicants INNER JOIN
                      Applicant_Sessions ON Applicants.Applicant_ID = Applicant_Sessions.Applicant_ID
WHERE     (Applicants.Applicant_ID = @Applicant_ID) and Assessment_ID = @Assessment_ID and Session_ID = @Session_ID


--motiv and z scores
select @rptscores=convert(varchar(2048),Report_Data) from Applicant_Report_Data 
   where Applicant_ID = @Applicant_ID and Assessment_ID=@Assessment_ID and Session_ID=@Session_ID and Report_ID like 'CandidateFormLetter_KPMG';
   

--alter xml header, kbr is unable to change their encoding type
set @xmlBuild = REPLACE(@xmlBuild, '"utf-8"', '"ISO-8859-1"')
set @xmlBuild = REPLACE(@xmlBuild, '"utf-16"', '"ISO-8859-1"')
set @xmlBuild = REPLACE(@xmlBuild, '"UTF-8"', '"ISO-8859-1"')
set @xmlBuild = REPLACE(@xmlBuild, '"UTF-16"', '"ISO-8859-1"')

--extract just 2nd payload from req and return all

set @xmlParse = CAST(@xmlBuild as XML)
-- "plpn" stands for payload plus name, inserting another copy of name there so that data encodes foreign characters consistently
select  top (1) '<?xml version="1.0" encoding="ISO-8859-1"?><plpn><altname>' + @FN + ' ' + @LN + '</altname>'+ T.Item.value('Payload[1]', 'varchar(1024)') + '</plpn>' as Payload1, @FN as FN, @LN as LN, @date1 as D1, @date2 as D2, @rptscores as Scores from @xmlParse.nodes('/Envelope/Packet') as T(Item)
order by Payload1 desc





GO
