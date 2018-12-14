SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	store/update applicant integration details
--				could be an alternate req, so increase Integration_ID and store as new record
--				or if same identical req, just update any changed details.
--				This should be whatever integration details are needed to post results back
--				for all received reqs if necessary.
-- History:		v1 - rollout
--
--			    v1.1 - added @Status_Code to drive logic to set "Active" bit.  (won't change 
--				once status code is 2 (complete) or if null passed in from AOR.  Only updates
--				upon applicant visit.
--
--				v1.2 - changed "Active" bit functionality, will be set true initially, then
--				false when results posted.  Optional param passed in to update.
--
--				v1.3 - note: table is using Integration_ID differently than its original use: to support multiple integrations.
--					   (Integration_ID now refers to # of different reqs)
--					   Adding Integration_System to be the identifier for integration (as in Integration_Info)
--					   Integration_Info will default to 1 for single ATS
--					   or possibly use 0/null to support both integrated and non-integrated.
--
--				v2	- removed Integration_B detail match to determine same req. taleo/directv integration b is unique per post, our receiptid.
--					  also prevent destroying return url when updating from index.asp and passing in null
--				v3 added expiration date to reqs - no option to update expire date
--				v3.1 - changed Matching_IntID lookup to use @Session_External_ID (Transaction) instead of @Integration_Detail_A (Recruiter)
--				v3.2 - added update to expiration date for matched record
-- =============================================
CREATE PROCEDURE [dbo].[ins_applicant_integration_req]
	(@Applicant_ID int,
     @Assessment_ID tinyint,
     @Session_ID tinyint,
     @Candidate_External_ID varchar(50), --Workday CandidateID
     @Requisition_ID varchar(50),
     @Session_External_ID varchar(50), --Workday TransactionID
     @Integration_Detail_A varchar(50), --Workday AssessedByID (Recrutier)
     @Integration_Detail_B varchar(50),
     @Dynamic_Ext_URL varchar(300),
     @Active_Req bit = NULL,  --can pass in null or 1=active, 0=inactive,
     @Integration_System tinyint = 2,
     @Expiration_Date datetime = null
    )
AS

-- What constitutes an identical req with new details?
--   Same Requisition_ID, Integration_Detail_A and Integration_Detail_B
--   would just update dynamic ext url and session_external_id if used
--   Candidate_External_ID probably always matches since it would be used
--   to determine Applicant_ID.

-- Candidate_External_ID always match Applicant table Login_ID?
--   For now, yes.
--
Declare @Matching_IntID tinyint


	SELECT  @Matching_IntID = Integration_ID
    FROM    dbo.Applicant_Integration_Data
	WHERE   Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID and Integration_System=@Integration_System and
			(Requisition_ID like @Requisition_ID or @Requisition_ID is null) and
			(Session_External_ID=@Session_External_ID or @Session_External_ID is null)

IF (@Matching_IntID IS NOT NULL)
	BEGIN
		--update ext url and ext id
		UPDATE dbo.Applicant_Integration_Data set
			Dynamic_Ext_URL = ISNULL(@Dynamic_Ext_URL, Dynamic_Ext_URL),
		    Session_External_ID = ISNULL(@Session_External_ID,Session_External_ID),
		    Active_Req = CASE
		    WHEN @Active_Req is null THEN Active_Req --unchanged
		    ELSE @Active_Req
						 END,
			Expiration_Date = CASE
		    WHEN @Expiration_Date is null THEN Expiration_Date --unchanged
		    ELSE @Expiration_Date
						 END
		WHERE
			Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID and Integration_System=@Integration_System and 
			Integration_ID = @Matching_IntID
		
	END
ELSE
	BEGIN
		
			--determine max integration_id for this user's session and increase by 1 for new req
		SELECT   @Matching_IntID = MAX(Integration_ID )
		FROM    dbo.Applicant_Integration_Data
		WHERE   Applicant_ID=@Applicant_ID and Assessment_ID=@Assessment_ID and	Session_ID=@Session_ID
		
		IF @Matching_IntID IS NULL
		   set @Matching_IntID = 0 --will still need to add 1
		
		INSERT INTO dbo.Applicant_Integration_Data
			   ([Applicant_ID]
			   ,[Assessment_ID]
			   ,[Session_ID]
			   ,[Integration_ID]
			   ,[Candidate_External_ID]
			   ,[Requisition_ID]
			   ,[Session_External_ID]
			   ,[Integration_Detail_A]
			   ,[Integration_Detail_B]
			   ,[Dynamic_Ext_URL],
			   Active_Req,
			   Integration_System,
			   Expiration_Date
			   )
		 VALUES
			   (@Applicant_ID
			   ,@Assessment_ID
			   ,@Session_ID
			   ,@Matching_IntID+1
			   ,@Candidate_External_ID
			   ,@Requisition_ID
			   ,@Session_External_ID
			   ,@Integration_Detail_A
			   ,@Integration_Detail_B
			   ,@Dynamic_Ext_URL
			   ,1	--Active_Req flag starts as true for any new req, turned false when results posted and acknowledged
			   ,@Integration_System,
			   @Expiration_Date
			   )

				
	
	END

GO
