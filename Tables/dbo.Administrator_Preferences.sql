CREATE TABLE [dbo].[Administrator_Preferences]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Time_Zone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Default_View] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dashboard_View] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Default_DateRange] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Default_DoubleClick_Action] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataGridType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrator_Preferences] ADD CONSTRAINT [PK_Administrator_Preferences] PRIMARY KEY CLUSTERED  ([Admin_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use, to allow advanced sorting or OLAP cube', 'SCHEMA', N'dbo', 'TABLE', N'Administrator_Preferences', 'COLUMN', N'DataGridType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Keyword-based, default to week, month, quarter, prev quarter, etc', 'SCHEMA', N'dbo', 'TABLE', N'Administrator_Preferences', 'COLUMN', N'Default_DateRange'
GO
EXEC sp_addextendedproperty N'MS_Description', N'1=Applicant Reports, 2=Tech Support', 'SCHEMA', N'dbo', 'TABLE', N'Administrator_Preferences', 'COLUMN', N'Default_DoubleClick_Action'
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC±n (or GMT±n), where n is the offset in hours', 'SCHEMA', N'dbo', 'TABLE', N'Administrator_Preferences', 'COLUMN', N'Time_Zone'
GO
