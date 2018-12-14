CREATE TABLE [dbo].[Scoring_Algorithms]
(
[Assessment_ID] [tinyint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Scoring_ID] [varchar] (99) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SPSS_Code] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Scoring_Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rollout_Date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scoring_Algorithms] ADD CONSTRAINT [PK_Scoring_Algorithms_1] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Scoring_Version]) ON [PRIMARY]
GO
