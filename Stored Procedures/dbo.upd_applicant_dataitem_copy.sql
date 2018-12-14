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
--				gets value from another data item
-- History:		v1 rollout
--				v1.1 top 1 fix in case multiple device types to copy
-- =============================================
CREATE PROCEDURE [dbo].[upd_applicant_dataitem_copy]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT = 1 ,
      @Item_Name VARCHAR(50) ,
      @Session_ID TINYINT ,
      @Status_Code TINYINT ,
      @Item_Name_to_Copy VARCHAR(50)
    )
AS
    SET NOCOUNT OFF;
    DECLARE @Item_ID SMALLINT;
    DECLARE @Current_Status_Code TINYINT;

    SELECT  @Item_ID = Item_ID
    FROM    Applicant_Items
    WHERE   Assessment_ID = @Assessment_ID
            AND ( ( Data_Title LIKE @Item_Name )
                  OR ( Report_Label LIKE @Item_Name )
                );

    SELECT  @Current_Status_Code = Status_Code
    FROM    dbo.Applicant_Sessions
    WHERE   Applicant_ID = @Applicant_ID
            AND Assessment_ID = @Assessment_ID
            AND Session_ID = @Session_ID;


    IF @Current_Status_Code = @Status_Code
        BEGIN
--check if exists, then update or insert
            IF NOT EXISTS ( SELECT  Item_ID
                            FROM    dbo.Applicant_Data
                            WHERE   Applicant_ID = @Applicant_ID
                                    AND Assessment_ID = @Assessment_ID
                                    AND Item_ID = @Item_ID
                                    AND Session_ID = @Session_ID )
                BEGIN
		   --write first time
                    INSERT  INTO [dbo].[Applicant_Data]
                            ( [Applicant_ID] ,
                              [Assessment_ID] ,
                              [Item_ID] ,
                              [Session_ID] ,
                              [Item_Value] ,
                              [Requisition_ID]
                            )
                            ( SELECT  TOP 1  @Applicant_ID ,
                                        @Assessment_ID ,
                                        @Item_ID ,
                                        @Session_ID ,
                                        dbo.Applicant_Data.Item_Value ,
                                        ''
                              FROM      dbo.Applicant_Data
                                        INNER JOIN dbo.Applicant_Items ON Applicant_Items.Assessment_ID = Applicant_Data.Assessment_ID
                                                              AND Applicant_Items.Item_ID = Applicant_Data.Item_ID
                              WHERE     Applicant_ID = @Applicant_ID
                                        AND dbo.Applicant_Items.Assessment_ID = @Assessment_ID
                                        AND Session_ID = @Session_ID
                                        AND dbo.Applicant_Items.Data_Title LIKE @Item_Name_to_Copy
                            );

						   
                END;
			--else do not update item once written
														

    

        END;
GO
