SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		js
-- Description:	get applicant data item
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_data_item]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Item_ID SMALLINT ,
      @Session_ID TINYINT ,
      @Requisition_ID VARCHAR(50) = ''
    )
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT TOP 1
                Item_Value
        FROM    dbo.Applicant_Data
        WHERE   Applicant_ID = @Applicant_ID
                AND Assessment_ID = @Assessment_ID
                AND Item_ID = @Item_ID
                AND Session_ID = @Session_ID
                AND ( Requisition_ID LIKE @Requisition_ID
                      OR @Requisition_ID = ''
                    );
  
    END;

GO
