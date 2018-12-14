CREATE TABLE [dbo].[Administrator_Notifications]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Notification_ID] [tinyint] NOT NULL,
[Criteria] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrator_Notifications] ADD CONSTRAINT [PK_Administrator_Notifications] PRIMARY KEY CLUSTERED  ([Admin_ID], [Notification_ID]) ON [PRIMARY]
GO
