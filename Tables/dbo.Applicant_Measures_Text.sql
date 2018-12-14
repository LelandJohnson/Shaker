CREATE TABLE [dbo].[Applicant_Measures_Text]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Measure_ID] [smallint] NOT NULL,
[Value] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Measures_Text] ADD CONSTRAINT [PK_Applicant_Measures_Text] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID], [Measure_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Measures_Text] ADD CONSTRAINT [FK_Applicant_Measures_Text_Applicant_Sessions] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
ALTER TABLE [dbo].[Applicant_Measures_Text] ADD CONSTRAINT [FK_Applicant_Measures_Text_Measures] FOREIGN KEY ([Measure_ID]) REFERENCES [dbo].[Measures] ([Measure_ID])
GO
