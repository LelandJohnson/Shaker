CREATE TABLE [dbo].[Admin_Permissions]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Permission_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Granted] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Permissions] ADD CONSTRAINT [PK_Admin_Permissions] PRIMARY KEY CLUSTERED  ([Admin_ID], [Permission_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Permissions] WITH NOCHECK ADD CONSTRAINT [FK_Admin_Permissions_Administrators] FOREIGN KEY ([Admin_ID]) REFERENCES [dbo].[Administrators] ([Admin_ID])
GO
ALTER TABLE [dbo].[Admin_Permissions] ADD CONSTRAINT [FK_Admin_Permissions_Permissions] FOREIGN KEY ([Permission_ID]) REFERENCES [dbo].[Permissions] ([Permission_ID])
GO
