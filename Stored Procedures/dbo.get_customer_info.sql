SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	get customer name, license info
--				pass in code or id if known
-- History:		v1
-- =============================================
CREATE PROCEDURE [dbo].[get_customer_info]
    (
      @Customer_Code VARCHAR(32) ,
      @Customer_ID SMALLINT ,
      @Assessment_ID TINYINT
	)
AS 
    SET NOCOUNT ON
	
    SELECT  Customers.Customer_ID ,
            Customers.Customer_Name ,
            Customers.Customer_Code ,
            Customer_Assessments.License_EndDate ,
            Customer_Assessments.License_Applicants_Remaining ,
            Customer_Assessments.Active ,
            Customer_Assessments.Assessment_ID ,
			DATEDIFF(DAY, GETDATE(), License_EndDate) AS [Days_Remaining]
    FROM    Customers
            INNER JOIN Customer_Assessments ON Customers.Customer_ID = Customer_Assessments.Customer_ID
    WHERE   ( Customer_Assessments.Assessment_ID = @Assessment_ID )
            AND ( Customer_Code LIKE ISNULL(@Customer_Code, '%') ) --look up code if passed in, otherwise any code
            AND ( dbo.Customers.Customer_ID >= ISNULL(@Customer_ID, 0) )     --look up numeric id otherwise 0-32767
            AND ( dbo.Customers.Customer_ID <= ISNULL(@Customer_ID, 32767) ) 


GO
