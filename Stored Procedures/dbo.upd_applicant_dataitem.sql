SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write Applicant_Data values
--				about applicant
-- History:		v1 rollout
--
--				v2 11/28/2011
--				   Adding optional Requisition_ID, data items will now be saved at req level, not just applicant/assessment/session.
--				   This will save all locations / recruiters / etc. for all the reqs an integrated candidate applies to.
--				   Default to blank for single-req systems?
--				   Using whole Requisition_ID here (like "2262B") instead of incrementing number Integration_ID from Applicant_Integration_Data
--				   because user data is written (or attempted) first before the integration data row, so that the result code will be known
--				   in case of errors.
-- =============================================
CREATE PROCEDURE [dbo].[upd_applicant_dataitem]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint = 1,
	@Item_ID smallint,
	@Session_ID tinyint,
	@Item_Value nvarchar(255),
	@Requisition_ID varchar(50) = ''
	)
	
AS
set nocount off

--check if exists, then update or insert
    IF NOT EXISTS ( SELECT  Item_ID
                    FROM    dbo.Applicant_Data
                    WHERE   Applicant_ID = @Applicant_ID and
							Assessment_ID = @Assessment_ID and
							Item_ID = @Item_ID and
							Session_ID = @Session_ID and
							Requisition_ID like @Requisition_ID ) 
		begin
		   --write first time
			INSERT INTO [dbo].[Applicant_Data]
					   ([Applicant_ID]
					   ,[Assessment_ID]
					   ,[Item_ID]
					   ,[Session_ID]
					   ,[Item_Value]
					   ,[Requisition_ID])
				 VALUES
					   (@Applicant_ID
					   ,@Assessment_ID
					   ,@Item_ID
					   ,@Session_ID
					   ,@Item_Value
					   ,@Requisition_ID)


						   
		end
	else
		begin
			--update item
			UPDATE [dbo].[Applicant_Data]
			   SET [Item_Value] = @Item_Value
			 WHERE 
				Applicant_ID = @Applicant_ID and
				Assessment_ID = @Assessment_ID and
				Item_ID = @Item_ID and
				Session_ID = @Session_ID and
				Requisition_ID like @Requisition_ID
														
        end
    

GO
