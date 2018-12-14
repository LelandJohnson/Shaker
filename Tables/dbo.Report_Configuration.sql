CREATE TABLE [dbo].[Report_Configuration]
(
[Assessment_ID] [tinyint] NOT NULL,
[Report_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Report_Variable] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Value] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Report_Configuration] ADD CONSTRAINT [PK_Report_Configuration] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Report_ID], [Report_Variable]) ON [PRIMARY]
GO
