CREATE TABLE [dbo].[Integration_Setup_Details]
(
[Integration_ID] [tinyint] NOT NULL,
[Communication_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Details] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Server_Application] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Error_Notification_Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Integration_Setup_Details] ADD CONSTRAINT [PK_Integration_Setup_Details] PRIMARY KEY CLUSTERED  ([Integration_ID], [Communication_Type]) ON [PRIMARY]
GO
