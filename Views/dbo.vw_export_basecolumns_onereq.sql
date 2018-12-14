SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_export_basecolumns_onereq]
AS
SELECT     ap.Applicant_ID AS aid, asn.Assessment_ID AS TestID, asn.Session_ID AS s, ad.Requisition_ID AS r, ap.First_Name AS fn, ap.Last_Name AS ln, ap.Login_ID AS id, 
                      ap.Employee_ID AS emp, ap.Other_ID AS id2, asn.Status_Code AS SC, CONVERT(nvarchar(100), asn.Start_Date, 20) AS SDate, CONVERT(nvarchar(100), 
                      asn.Applicant_Start_Date, 20) AS ASDate, CONVERT(nvarchar(100), asn.Last_Activity_Date, 20) AS ActivDate, CONVERT(nvarchar(100), asn.Completion_Date, 20) 
                      AS CDate, asn.Elapsed_Time AS ttime, asn.Question_Time AS qtime, asn.Results_Overall AS Score, asn.Scoring_Version AS scorever, asn.Content_Version AS cv, 
                      asn.Language_Code AS lang, asn.Alt_Version AS altver, MAX(CASE WHEN (Item_ID = 1) THEN (Item_Value) ELSE '' END) AS d1, MAX(CASE WHEN (Item_ID = 2) 
                      THEN (Item_Value) ELSE '' END) AS d2, MAX(CASE WHEN (Item_ID = 3) THEN (Item_Value) ELSE '' END) AS d3, MAX(CASE WHEN (Item_ID = 4) THEN (Item_Value) 
                      ELSE '' END) AS d4, MAX(CASE WHEN (Item_ID = 5) THEN (Item_Value) ELSE '' END) AS d5, MAX(CASE WHEN (Item_ID = 6) THEN (Item_Value) ELSE '' END) AS d6, 
                      MAX(CASE WHEN (Item_ID = 7) THEN (Item_Value) ELSE '' END) AS d7, MAX(CASE WHEN (Item_ID = 8) THEN (Item_Value) ELSE '' END) AS d8, 
                      MAX(CASE WHEN (Item_ID = 9) THEN (Item_Value) ELSE '' END) AS d9, MAX(CASE WHEN (Item_ID = 10) THEN (Item_Value) ELSE '' END) AS d10, 
                      MAX(CASE WHEN (Item_ID = 11) THEN (Item_Value) ELSE '' END) AS d11, MAX(CASE WHEN (Item_ID = 12) THEN (Item_Value) ELSE '' END) AS d12, 
                      MAX(CASE WHEN (Item_ID = 13) THEN (Item_Value) ELSE '' END) AS d13, MAX(CASE WHEN (Item_ID = 14) THEN (Item_Value) ELSE '' END) AS d14, 
                      MAX(CASE WHEN (Item_ID = 15) THEN (Item_Value) ELSE '' END) AS d15, MAX(CASE WHEN (Item_ID = 16) THEN (Item_Value) ELSE '' END) AS d16, 
                      MAX(CASE WHEN (Item_ID = 17) THEN (Item_Value) ELSE '' END) AS d17, MAX(CASE WHEN (Item_ID = 18) THEN (Item_Value) ELSE '' END) AS d18, 
                      MAX(CASE WHEN (Item_ID = 19) THEN (Item_Value) ELSE '' END) AS d19, MAX(CASE WHEN (Item_ID = 20) THEN (Item_Value) ELSE '' END) AS d20, 
                      MAX(CASE WHEN (Item_ID = 21) THEN (Item_Value) ELSE '' END) AS d21, MAX(CASE WHEN (Item_ID = 22) THEN (Item_Value) ELSE '' END) AS d22, 
                      MAX(CASE WHEN (Item_ID = 23) THEN (Item_Value) ELSE '' END) AS d23, MAX(CASE WHEN (Item_ID = 24) THEN (Item_Value) ELSE '' END) AS d24, 
                      MAX(CASE WHEN (Item_ID = 25) THEN (Item_Value) ELSE '' END) AS d25, MAX(CASE WHEN (Item_ID = 26) THEN (Item_Value) ELSE '' END) AS d26, 
                      MAX(CASE WHEN (Item_ID = 27) THEN (Item_Value) ELSE '' END) AS d27, MAX(CASE WHEN (Item_ID = 28) THEN (Item_Value) ELSE '' END) AS d28, 
                      MAX(CASE WHEN (Item_ID = 29) THEN (Item_Value) ELSE '' END) AS d29, MAX(CASE WHEN (Item_ID = 30) THEN (Item_Value) ELSE '' END) AS d30, 
                      MAX(CASE WHEN (Item_ID = 31) THEN (Item_Value) ELSE '' END) AS d31, MAX(CASE WHEN (Item_ID = 32) THEN (Item_Value) ELSE '' END) AS d32
FROM         dbo.Applicants AS ap INNER JOIN
                      dbo.Applicant_Sessions AS asn ON ap.Applicant_ID = asn.Applicant_ID /*the most recent req from applicant_integration_data */
                       OUTER APPLY
                          (
							SELECT    Applicant_Data.*
							FROM         Applicant_Integration_Data INNER JOIN
												  Applicant_Data ON Applicant_Integration_Data.Applicant_ID = Applicant_Data.Applicant_ID and
																	Applicant_Integration_Data.Requisition_ID = Applicant_Data.Requisition_ID and
																	Applicant_Integration_Data.Assessment_ID = Applicant_Data.Assessment_ID and 
																	Applicant_Integration_Data.Session_ID= Applicant_Data.Session_ID 
							WHERE     (asn.Applicant_ID = Applicant_Integration_Data.Applicant_ID) AND (asn.Session_ID = Applicant_Integration_Data.Session_ID) AND (Applicant_Integration_Data.Assessment_ID = asn.Assessment_ID) AND 
												  (Applicant_Integration_Data.Requisition_ID =
													  (SELECT     TOP (1) Requisition_ID
														FROM          Applicant_Integration_Data AS Applicant_Integration_Data_1
														WHERE      (Applicant_ID = asn.Applicant_ID) AND (Session_ID = asn.Session_ID) AND (Assessment_ID = asn.Assessment_ID)
														ORDER BY Integration_ID desc))                          
													   )
                       ad
GROUP BY ap.Applicant_ID, ap.First_Name, ap.Last_Name, ap.Login_ID, ap.Employee_ID, ap.Other_ID, asn.Status_Code, asn.Assessment_ID, asn.Start_Date, 
                      asn.Completion_Date, asn.Session_ID, asn.Results_Overall, ad.Requisition_ID, asn.Applicant_Start_Date, asn.Last_Activity_Date, asn.Elapsed_Time, 
                      asn.Question_Time, asn.Scoring_Version, asn.Content_Version, asn.Language_Code, asn.Alt_Version


GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'vw_export_basecolumns_onereq', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_export_basecolumns_onereq', NULL, NULL
GO
