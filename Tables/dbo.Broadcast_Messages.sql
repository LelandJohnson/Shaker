CREATE TABLE [dbo].[Broadcast_Messages]
(
[Message_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NULL,
[Message_HTML] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active_Date_From] [datetime] NULL,
[Active_Date_To] [datetime] NULL,
[Enabled] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Broadcast_Messages] ADD CONSTRAINT [PK_Broadcast_Messages] PRIMARY KEY CLUSTERED  ([Message_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Assessment to show message or null for all in database', 'SCHEMA', N'dbo', 'TABLE', N'Broadcast_Messages', 'COLUMN', N'Assessment_ID'
GO
