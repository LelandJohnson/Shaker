CREATE TABLE [dbo].[ApplicationLogEntries]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TimeStamp] [datetime] NOT NULL,
[ThreadId] [int] NOT NULL,
[Level] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Message] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApplicationLogEntries] ADD CONSTRAINT [PK_ApplicationLogEntries] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
