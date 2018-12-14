CREATE TABLE [dbo].[Measures]
(
[Measure_ID] [smallint] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Content_Version] [real] NOT NULL,
[Measure_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Textual] [bit] NULL,
[Required] [bit] NULL,
[Section_Abbr] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Section_Order] [tinyint] NULL,
[Item_Order] [smallint] NULL,
[Unscored] [bit] NULL,
[Cumulative] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Measures] ADD CONSTRAINT [PK_Measures_1] PRIMARY KEY CLUSTERED  ([Measure_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Measures] ADD CONSTRAINT [FK_Measures_Assessments] FOREIGN KEY ([Assessment_ID]) REFERENCES [dbo].[Assessments] ([Assessment_ID])
GO
