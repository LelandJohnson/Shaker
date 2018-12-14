SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write Applicant_Data values
--				about applicant, by item name instead of item_id
--				only write if @Status_Code matches applicant_session
--				assumes not req specific
-- History:		v1 rollout
--				v1.1 for integrated systems req-specific applicant_data
-- =============================================
CREATE PROCEDURE [dbo].[upd_applicant_dataitem_by_name_and_status]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint = 1,
	@Item_Name VARCHAR(50),
	@Session_ID tinyint,
	@Item_Value nvarchar(255),
	@Status_Code TINYINT,
	@Requisition_ID VARCHAR(50) = ''
	)
	
AS
set nocount off
DECLARE @Item_ID SMALLINT;
DECLARE @Current_Status_Code TINYINT;

SELECT @Item_ID=Item_ID FROM Applicant_Items WHERE Assessment_ID=@Assessment_ID AND
 (
 (Data_Title LIKE @Item_Name )
 OR
 (Report_Label LIKE @Item_Name )
 )

 SELECT @Current_Status_Code=Status_Code FROM dbo.Applicant_Sessions WHERE
  Applicant_ID=@Applicant_ID AND
  Assessment_ID=@Assessment_ID AND 
  Session_ID=@Session_ID


IF @Current_Status_Code=@Status_Code
BEGIN
--check if exists, then update or insert
    IF NOT EXISTS ( SELECT  Item_ID
                    FROM    dbo.Applicant_Data
                    WHERE   Applicant_ID = @Applicant_ID and
							Assessment_ID = @Assessment_ID and
							Item_ID = @Item_ID and
							Session_ID = @Session_ID AND
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
				Session_ID = @Session_ID  AND
                Requisition_ID like @Requisition_ID
														
        end
    

END
GO
