CREATE TABLE [dbo].[Integration_Exceptions]
(
[Receipt_ID] [int] NOT NULL IDENTITY(1, 1),
[Timestamp] [datetime] NULL CONSTRAINT [DF_Integration_Exceptions_Timestamp] DEFAULT (getdate()),
[Remote_IP] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data_Received] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Integration_Exceptions] ADD CONSTRAINT [PK_Integration_Exceptions] PRIMARY KEY CLUSTERED  ([Receipt_ID]) ON [PRIMARY]
GO
