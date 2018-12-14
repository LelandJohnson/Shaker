CREATE TABLE [dbo].[Security_Levels]
(
[Sec_Level_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Level_Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Level_Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Security_Levels] ADD CONSTRAINT [PK_Security_Levels] PRIMARY KEY CLUSTERED  ([Sec_Level_ID]) ON [PRIMARY]
GO
