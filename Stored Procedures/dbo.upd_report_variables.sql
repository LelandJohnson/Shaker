SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		jw
-- Description:	Insert/Update xml of report drivers
--				pass in xml containing rows of scoring computed variables and their values
--				in the format:
--				<rp>
--				  <Z_COMP_DevPeople>-0.35</Z_COMP_DevPeople>
--				  <Z_COMP_Accountability>0</Z_COMP_Accountability>
--				  <Z_COMP_Excellence>-0.53</Z_COMP_Excellence>
--				</rp>
--
--				Store in Applicant_Report_Data for corresponding Report_ID
--				Report_ID's can be re-used by multiple reports that all rely on
--				subsets of the same report xml data stored here.
-- History:		v1
-- =============================================

CREATE PROCEDURE [dbo].[upd_report_variables] (

   @Applicant_ID  int,
   @Assessment_ID tinyint,
   @Session_ID tinyint,
   @Scoring_Version real,
   @Report_ID varchar(50),
   @Report_XML xml
   )
    AS

if not exists (
   SELECT Applicant_ID
   FROM   Applicant_Report_Data d
   WHERE  
          d.Applicant_ID = @Applicant_ID and
		  d.Assessment_ID = @Assessment_ID and
		  d.Session_ID = @Session_ID and
		  d.Scoring_Version = @Scoring_Version and
		  d.Report_ID like @Report_ID
   
   )
   begin
      --insert
		insert into Applicant_Report_Data (Applicant_ID, Assessment_ID,
		Session_ID, Scoring_Version, Report_ID, Report_Data) values 
		(@Applicant_ID, @Assessment_ID, @Session_ID,
		@Scoring_Version, @Report_ID, @Report_XML)
		
		  		
   end
else
   begin
--	  --update
      update Applicant_Report_Data set Report_Data = @Report_XML
	 where Applicant_ID = @Applicant_ID and
		   Assessment_ID = @Assessment_ID and
		   Session_ID = @Session_ID and
		   Scoring_Version = @Scoring_Version and
		   Report_ID = @Report_ID

   end
     
GO
