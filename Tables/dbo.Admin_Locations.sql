CREATE TABLE [dbo].[Admin_Locations]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_ID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Locations] ADD CONSTRAINT [PK_Admin_Locations] PRIMARY KEY CLUSTERED  ([Admin_ID], [Location_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin_Locations] ADD CONSTRAINT [FK_Admin_Locations_Administrators] FOREIGN KEY ([Admin_ID]) REFERENCES [dbo].[Administrators] ([Admin_ID])
GO
ALTER TABLE [dbo].[Admin_Locations] ADD CONSTRAINT [FK_Admin_Locations_Locations] FOREIGN KEY ([Location_ID]) REFERENCES [dbo].[Locations] ([Location_ID])
GO
