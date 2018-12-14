CREATE TABLE [dbo].[AuditEvents]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TimeStamp] [datetime] NOT NULL,
[EventType] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditEvents] ADD CONSTRAINT [PK_AuditEvents] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
