CREATE TABLE [dbo].[Integration_Details]
(
[Receipt_ID] [int] NOT NULL IDENTITY(1, 1),
[Applicant_ID] [int] NULL,
[External_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Assessment_ID] [tinyint] NULL,
[Session_ID] [tinyint] NULL,
[Communication_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Timestamp] [datetime] NULL,
[Success] [bit] NULL,
[Return_Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[External_Receipt_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data_Sent] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data_Received] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_System] [tinyint] NULL CONSTRAINT [DF_Integration_Details_Integration_System] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Integration_Details] ADD CONSTRAINT [PK_Integration_Receipts] PRIMARY KEY CLUSTERED  ([Receipt_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Integration_Details] ADD CONSTRAINT [FK_Integration_Details_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Copy of packet received, size permitting or periodically purged ', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Details', 'COLUMN', N'Data_Received'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Copy of packet sent, size permitting or periodically purged ', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Details', 'COLUMN', N'Data_Sent'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Applicant / Candidate unique identifier in external system integration', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Details', 'COLUMN', N'External_ID'
GO
