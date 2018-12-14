CREATE TABLE [dbo].[Report_Probes]
(
[Assessment_ID] [tinyint] NOT NULL,
[Measure_Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response] [smallint] NOT NULL,
[Report_Text] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Probe] [varchar] (1200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category_Order] [tinyint] NULL,
[ItemOrder] [tinyint] NULL,
[Content_Version] [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Report_Probes] ADD CONSTRAINT [PK_Report_Probes] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Measure_Name], [Response]) ON [PRIMARY]
GO
