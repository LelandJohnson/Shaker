CREATE TABLE [dbo].[DevFeedback_Scales]
(
[Assessment_ID] [tinyint] NOT NULL,
[Scale_ID] [smallint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Competency] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Scale] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Category_Order] [smallint] NOT NULL,
[Comp_Order] [smallint] NOT NULL,
[Scale_Order] [smallint] NOT NULL,
[Low_Bullet] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[High_Bullet] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Low_Val] [float] NULL,
[High_Val] [float] NULL,
[Language_Code] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DevFeedback_Scales_Language_Code] DEFAULT ('en-US')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DevFeedback_Scales] ADD CONSTRAINT [PK_DevFeedback_Scales] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Scale_ID], [Scoring_Version], [Language_Code]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'In a DFR spec sheet, add a new column that just numbers the items for this assessment & scoring version', 'SCHEMA', N'dbo', 'TABLE', N'DevFeedback_Scales', 'COLUMN', N'Scale_ID'
GO
