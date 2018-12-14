SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get an applicant data item for the order id requested
--				also pass in applicant_id un case order id's are not unique like pan
--				originally made to retrieve CountryCode for pan-Amazon branching
-- History:		v1 jw 3/21/2016
--				v1.5 jw 5/22/2016 better multiple assessment handling
--              v1.5.1 js 6/30/16 changed where clause 'dbo.Applicant_Data.Applicant_ID=@Assessment_ID' to 'dbo.Applicant_Data.Assessment_ID=@Assessment_ID'
-- =============================================
CREATE PROCEDURE [dbo].[get_applicant_data_item_for_req]
    (
      @Applicant_ID INT ,
      @Assessment_ID TINYINT ,
      @Order_ID VARCHAR(50) ,
      @Data_Title VARCHAR(50) = '%' --no data_title will return all items
	)
AS
    SET NOCOUNT ON;

    SELECT  Applicant_Data.Applicant_ID ,
            Applicant_Data.Assessment_ID ,
            Applicant_Data.Item_ID ,
            Applicant_Data.Session_ID ,
            Applicant_Data.Requisition_ID ,
            Applicant_Data.Item_Value ,
            Applicant_Items.Data_Title
    FROM    Applicant_Data
            INNER JOIN Applicant_Items ON Applicant_Data.Assessment_ID = Applicant_Items.Assessment_ID
                                          AND Applicant_Data.Item_ID = Applicant_Items.Item_ID
    WHERE   ( Applicant_Items.Data_Title LIKE @Data_Title )
            AND ( Applicant_Data.Requisition_ID LIKE @Order_ID )
            AND Applicant_ID = @Applicant_ID
            AND dbo.Applicant_Data.Assessment_ID = @Assessment_ID
    ORDER BY Applicant_Data.Item_ID ASC;  


GO
