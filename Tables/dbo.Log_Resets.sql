CREATE TABLE [dbo].[Log_Resets]
(
[Log_Item_ID] [int] NOT NULL,
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Timestamp] [datetime] NOT NULL,
[Action] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comment] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_Resets] ADD CONSTRAINT [PK_Log_Resets] PRIMARY KEY CLUSTERED  ([Log_Item_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_Resets] ADD CONSTRAINT [FK_Log_Resets_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
