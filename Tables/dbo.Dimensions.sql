CREATE TABLE [dbo].[Dimensions]
(
[Assessment_ID] [tinyint] NOT NULL,
[Dimension_ID] [tinyint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Dimension_Name] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dimension_Definition] [varchar] (3000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dimension_Flagged_Definition] [varchar] (3000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Flag_Criteria] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dimension_Abbr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Report_Order] [tinyint] NULL,
[SPSS_Variable] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Is_Overall] [bit] NULL,
[Is_OtherOverall1] [bit] NULL,
[Is_OtherOverall2] [bit] NULL,
[SymbolTableLookup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dimensions] ADD CONSTRAINT [PK_Dimensions] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Dimension_ID], [Scoring_Version]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Optional shorter name for integration results, column headers', 'SCHEMA', N'dbo', 'TABLE', N'Dimensions', 'COLUMN', N'Dimension_Abbr'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Order displayed on report', 'SCHEMA', N'dbo', 'TABLE', N'Dimensions', 'COLUMN', N'Report_Order'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Scoring algorithm version.  Allows a renorm to add another dimension', 'SCHEMA', N'dbo', 'TABLE', N'Dimensions', 'COLUMN', N'Scoring_Version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For foreign languages, use this code to look up translated text', 'SCHEMA', N'dbo', 'TABLE', N'Dimensions', 'COLUMN', N'SymbolTableLookup'
GO
