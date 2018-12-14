CREATE TABLE [dbo].[Applicant_Data]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Item_ID] [smallint] NOT NULL,
[Session_ID] [tinyint] NOT NULL CONSTRAINT [DF_Applicant_Data_Session_ID] DEFAULT ((1)),
[Requisition_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Value] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Data] ADD CONSTRAINT [PK_Applicant_Data] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Item_ID], [Session_ID], [Requisition_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Data] ADD CONSTRAINT [FK_Applicant_Data_Applicant_Items] FOREIGN KEY ([Assessment_ID], [Item_ID]) REFERENCES [dbo].[Applicant_Items] ([Assessment_ID], [Item_ID])
GO
ALTER TABLE [dbo].[Applicant_Data] ADD CONSTRAINT [FK_Applicant_Data_Applicants] FOREIGN KEY ([Applicant_ID]) REFERENCES [dbo].[Applicants] ([Applicant_ID])
GO
