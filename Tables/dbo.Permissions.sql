CREATE TABLE [dbo].[Permissions]
(
[Permission_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Permission_Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Permissions] ADD CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED  ([Permission_ID]) ON [PRIMARY]
GO
