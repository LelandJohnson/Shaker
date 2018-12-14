CREATE TABLE [dbo].[Configuration]
(
[Assessment_ID] [tinyint] NOT NULL,
[Production_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Production_URL_Int] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Staging_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Staging_URL_Int] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status_ChangeDate] [datetime] NULL,
[RJP_Mode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RJP_Staging_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RJP_Production_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApplicantPW_Hash] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Production_Repost_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Staging_Repost_URL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Configuration] ADD CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED  ([Assessment_ID]) ON [PRIMARY]
GO
