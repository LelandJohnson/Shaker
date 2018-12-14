CREATE TABLE [dbo].[Scale_Scores]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Scale] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Scale_Score] [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scale_Scores] ADD CONSTRAINT [PK_Scale_Scores] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID], [Scale], [Scoring_Version]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scale_Scores] ADD CONSTRAINT [FK_Scale_Scores_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
