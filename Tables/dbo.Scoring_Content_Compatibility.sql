CREATE TABLE [dbo].[Scoring_Content_Compatibility]
(
[Assessment_ID] [tinyint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Content_Version] [real] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scoring_Content_Compatibility] ADD CONSTRAINT [PK_Scoring_Content_Compatibility] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Scoring_Version], [Content_Version]) ON [PRIMARY]
GO
