CREATE TABLE [dbo].[Applicant_Integration_Data]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Integration_ID] [tinyint] NOT NULL,
[Integration_System] [tinyint] NOT NULL CONSTRAINT [DF_Applicant_Integration_Data_Integration_System] DEFAULT ((1)),
[Candidate_External_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Requisition_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Session_External_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_Detail_A] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_Detail_B] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dynamic_Ext_URL] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active_Req] [bit] NULL,
[Expiration_Date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Integration_Data] ADD CONSTRAINT [PK_Integration_Details] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID], [Integration_ID], [Integration_System]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Data about each applicant''s session needed to communicate with 3rd party system', 'SCHEMA', N'dbo', 'TABLE', N'Applicant_Integration_Data', NULL, NULL
GO
