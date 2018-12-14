CREATE TABLE [dbo].[Admin_Assessments]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Assessment_ID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Assessments] ADD CONSTRAINT [PK_Admin_Assessments] PRIMARY KEY CLUSTERED  ([Admin_ID], [Assessment_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Assessments] ADD CONSTRAINT [FK_Admin_Assessments_Administrators] FOREIGN KEY ([Admin_ID]) REFERENCES [dbo].[Administrators] ([Admin_ID])
GO
ALTER TABLE [dbo].[Admin_Assessments] ADD CONSTRAINT [FK_Admin_Assessments_Assessments] FOREIGN KEY ([Assessment_ID]) REFERENCES [dbo].[Assessments] ([Assessment_ID])
GO
