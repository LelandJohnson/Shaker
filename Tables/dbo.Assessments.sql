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
