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
EXEC sp_addextendedproperty N'MS_Description', N'Assessment Order Request, Assessment Order Acknowledgement, Assessment Result, Assessment Status Request', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Setup_Details', 'COLUMN', N'Communication_Type'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Details of the data format and protocol for the exchange', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Setup_Details', 'COLUMN', N'Details'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Aside from stg notification on failures, copy this distribution list', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Setup_Details', 'COLUMN', N'Error_Notification_Email'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Path to program that handles this integration comm', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Setup_Details', 'COLUMN', N'Server_Application'
GO
