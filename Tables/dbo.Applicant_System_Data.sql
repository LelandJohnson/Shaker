CREATE TABLE [dbo].[Applicant_System_Data]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[AppCodeName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AppName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AppVersion] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CookieEnabled] [bit] NULL,
[Language] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Platform] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Product] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserAgent] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ScreenWidth] [smallint] NULL,
[ScreenHeight] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_System_Data] ADD CONSTRAINT [PK_Applicant_System_Data] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_System_Data] ADD CONSTRAINT [FK_Applicant_System_Data_Applicant_Session] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
