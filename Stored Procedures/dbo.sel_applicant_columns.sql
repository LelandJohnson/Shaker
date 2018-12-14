SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		js
-- Description:	get list of applicant data items to be displayed in grid
-- History:		v1 non-xml port of [get_applicant_columns]
--				v1.1 removed [Non_Assessment_Data]  for ShakerLeeTest version
-- =============================================
CREATE PROCEDURE [dbo].[sel_applicant_columns]
    (
      @Assessment_ID TINYINT
    )
AS
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT  Applicant_Items.Item_ID ,
                Applicant_Items.Data_Title ,
                Applicant_Items.Item_Type ,
                Applicant_Items.Report_Label ,
                Applicant_Items.EEOC ,
                Applicant_Items.Conceal_Display
        FROM    Applicant_Items
        WHERE   Applicant_Items.Assessment_ID = @Assessment_ID
           --     AND ( ( Non_Assessment_Data = 0 )
            --          OR ( Non_Assessment_Data IS NULL )
            --        )
        ORDER BY Applicant_Items.Item_ID;
      
    END;
GO
