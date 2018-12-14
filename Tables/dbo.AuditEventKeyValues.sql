CREATE TABLE [dbo].[AuditEventKeyValues]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Key] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Value] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AuditEvent_Id] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditEventKeyValues] ADD CONSTRAINT [PK_AuditEventKeyValues] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditEventKeyValues] ADD CONSTRAINT [FK_AuditEventKeyValues_AuditEvents] FOREIGN KEY ([AuditEvent_Id]) REFERENCES [dbo].[AuditEvents] ([Id])
GO
