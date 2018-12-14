SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	pass in session filters (date, status code)
--				returns basic applicant + session info
--				and numeric measures.
--				this returns a large list for the aspx to handle pivoting, which would become
--			    even larger if extended session and applicant columns are added.
--				(compare overall speed and network impact with export_applicant_measures_num)
-- History:		v1
--				v2 4/20/2012 added comments
-- =============================================
CREATE PROCEDURE [dbo].[export_measures]
	-- Add the parameters for the stored procedure here
	@Assessment_ID tinyint = 1,
	@Start_Date_From datetime,
	@Start_Date_To datetime,
	@Completion_Date_From datetime,
	@Completion_Date_To datetime,
	@Status_Code1 smallint,
	@Status_Code2 smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     [asn].Applicant_ID, [asn].Session_ID, [ap].Last_Name, [ap].First_Name, [ap].Login_ID, [ap].Employee_ID, 
                      [asn].Start_Date, [m].Measure_Name, Applicant_Measures_Num.Value
FROM         Applicants as [ap] INNER JOIN
                      Applicant_Sessions as [asn] ON [ap].Applicant_ID = [asn].Applicant_ID LEFT OUTER JOIN
                      Measures as [m] INNER JOIN
                      Applicant_Measures_Num ON [m].Measure_ID = Applicant_Measures_Num.Measure_ID ON 
                      [asn].Applicant_ID = Applicant_Measures_Num.Applicant_ID AND [asn].Assessment_ID = Applicant_Measures_Num.Assessment_ID AND 
                      [asn].Session_ID = Applicant_Measures_Num.Session_ID
WHERE     ([asn].Assessment_ID = @Assessment_ID) and
		  ((@Start_Date_From is null) or ([asn].[Start_Date]>=@Start_Date_From)) and
		  ((@Start_Date_To is null) or ([asn].[Start_Date]<=@Start_Date_To)) and
		  ((@Completion_Date_From is null) or ([asn].Completion_Date>=@Completion_Date_From)) and
		  ((@Completion_Date_To is null) or ([asn].Completion_Date<=@Completion_Date_To)) and
		  ( 
		  ((@Status_Code1 is null) or (Status_Code = @Status_Code1)) and
		  ((@Status_Code2 is null) or (Status_Code = @Status_Code2))
		  )
		  --and [asn].Applicant_ID<2000
order by applicant_ID, Session_ID, m.Section_Order, m.Item_Order

END

GO
