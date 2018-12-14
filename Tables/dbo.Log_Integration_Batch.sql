CREATE TABLE [dbo].[Log_Integration_Batch]
(
[Timestamp] [datetime] NOT NULL,
[Post_Count] [int] NOT NULL,
[Post_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Log_Integration_Batch] ON [dbo].[Log_Integration_Batch] ([Timestamp] DESC) ON [PRIMARY]
GO
