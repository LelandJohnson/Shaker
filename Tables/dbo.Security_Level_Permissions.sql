CREATE TABLE [dbo].[Security_Level_Permissions]
(
[Sec_Level_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Permission_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Granted] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Security_Level_Permissions] ADD CONSTRAINT [PK_Security_Level_Permissions] PRIMARY KEY CLUSTERED  ([Sec_Level_ID], [Permission_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Security_Level_Permissions] ADD CONSTRAINT [FK_Security_Level_Permissions_Permissions] FOREIGN KEY ([Permission_ID]) REFERENCES [dbo].[Permissions] ([Permission_ID])
GO
ALTER TABLE [dbo].[Security_Level_Permissions] ADD CONSTRAINT [FK_Security_Level_Permissions_Security_Levels] FOREIGN KEY ([Sec_Level_ID]) REFERENCES [dbo].[Security_Levels] ([Sec_Level_ID])
GO
