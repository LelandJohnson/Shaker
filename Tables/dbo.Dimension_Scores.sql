CREATE TABLE [dbo].[Dimension_Scores]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Dimension_ID] [tinyint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Dimension_Score] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dimension_Scores] ADD CONSTRAINT [PK_Dimension_Scores] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Dimension_ID], [Scoring_Version], [Session_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dimension_Scores] ADD CONSTRAINT [FK_Dimension_Scores_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
ALTER TABLE [dbo].[Dimension_Scores] ADD CONSTRAINT [FK_Dimension_Scores_Dimensions] FOREIGN KEY ([Assessment_ID], [Dimension_ID], [Scoring_Version]) REFERENCES [dbo].[Dimensions] ([Assessment_ID], [Dimension_ID], [Scoring_Version])
GO
