CREATE TABLE [dbo].[Admin_Security_Levels]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sec_Level_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Security_Levels] ADD CONSTRAINT [PK_Admin_Security_Levels] PRIMARY KEY CLUSTERED  ([Admin_ID], [Sec_Level_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Security_Levels] WITH NOCHECK ADD CONSTRAINT [FK_Admin_Security_Levels_Administrators] FOREIGN KEY ([Admin_ID]) REFERENCES [dbo].[Administrators] ([Admin_ID])
GO
ALTER TABLE [dbo].[Admin_Security_Levels] ADD CONSTRAINT [FK_Admin_Security_Levels_Security_Levels] FOREIGN KEY ([Sec_Level_ID]) REFERENCES [dbo].[Security_Levels] ([Sec_Level_ID])
GO
