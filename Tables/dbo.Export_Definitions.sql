CREATE TABLE [dbo].[Export_Definitions]
(
[Assessment_ID] [tinyint] NOT NULL,
[Export_ID] [varchar] (99) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Header_Row] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Export_Definitions] ADD CONSTRAINT [PK_Export_Definitions] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Export_ID], [Scoring_Version]) ON [PRIMARY]
GO
