CREATE TABLE [dbo].[Log_Administration]
(
[Log_Item_ID] [int] NOT NULL,
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Assessment_ID] [tinyint] NULL,
[Timestamp] [datetime] NOT NULL,
[Action] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comment] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_Administration] ADD CONSTRAINT [PK_Log_Administration] PRIMARY KEY CLUSTERED  ([Log_Item_ID]) ON [PRIMARY]
GO
