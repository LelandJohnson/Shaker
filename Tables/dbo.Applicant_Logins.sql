CREATE TABLE [dbo].[Applicant_Logins]
(
[Logon_EventID] [int] NOT NULL IDENTITY(1, 1),
[Applicant_ID] [int] NULL,
[Assessment_ID] [tinyint] NULL,
[Session_ID] [tinyint] NULL,
[Timestamp] [datetime] NULL CONSTRAINT [DF_Applicant_Logins_Timestamp] DEFAULT (getdate()),
[Bookmark_at_Login] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[User_Agent] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Flash_Version] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[System_Width] [smallint] NULL,
[System_Height] [smallint] NULL,
[Avail_Width] [smallint] NULL,
[Avail_Height] [smallint] NULL,
[Popup_OK] [bit] NULL,
[Sound_Test] [bit] NULL,
[HTTPS] [bit] NULL,
[Server_Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Remote_IP] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Logins] ADD CONSTRAINT [PK_Browser_Checks] PRIMARY KEY CLUSTERED  ([Logon_EventID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Logins] ADD CONSTRAINT [FK_Applicant_Logins_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
