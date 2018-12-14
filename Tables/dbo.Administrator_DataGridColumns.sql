CREATE TABLE [dbo].[Administrator_DataGridColumns]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Applicant_Item_List] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrator_DataGridColumns] ADD CONSTRAINT [PK_Administrator_DataGridColumns] PRIMARY KEY CLUSTERED  ([Admin_ID], [Assessment_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrator_DataGridColumns] ADD CONSTRAINT [FK_Administrator_DataGridColumns_Administrators] FOREIGN KEY ([Admin_ID]) REFERENCES [dbo].[Administrators] ([Admin_ID])
GO
ALTER TABLE [dbo].[Administrator_DataGridColumns] ADD CONSTRAINT [FK_Administrator_DataGridColumns_Assessments] FOREIGN KEY ([Assessment_ID]) REFERENCES [dbo].[Assessments] ([Assessment_ID])
GO
