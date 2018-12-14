CREATE TABLE [dbo].[Assessments]
(
[Assessment_ID] [tinyint] NOT NULL,
[Assessment_Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Full_Title] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Short_Title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Branding_ID] [tinyint] NULL,
[Retake_Policy_Months] [smallint] NULL,
[Restart_Policy_Months] [smallint] NULL,
[Settings] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FlashFileName] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MainXmlPath] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Debug] [bit] NOT NULL CONSTRAINT [DF_Assessments_Debug] DEFAULT ((0)),
[HelpSiteURL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Assessments_HelpSiteURL] DEFAULT (NULL)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assessments] ADD CONSTRAINT [PK_Assessments] PRIMARY KEY CLUSTERED  ([Assessment_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assessments] WITH NOCHECK ADD CONSTRAINT [FK_Assessments_Branding] FOREIGN KEY ([Branding_ID]) REFERENCES [dbo].[Branding] ([Branding_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Assessment ID, properties and metadata', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Abbreviation for customer + assessment name', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', 'COLUMN', N'Assessment_Code'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Assessment identifying number within database', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', 'COLUMN', N'Assessment_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ID of brand/company within database to use in GUI', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', 'COLUMN', N'Branding_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of incomplete days/weeks/months/years before forcing new session', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', 'COLUMN', N'Restart_Policy_Months'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of days/weeks/months/years before allowing retake', 'SCHEMA', N'dbo', 'TABLE', N'Assessments', 'COLUMN', N'Retake_Policy_Months'
GO
