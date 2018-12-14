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
