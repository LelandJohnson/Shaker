CREATE TABLE [dbo].[Applicant_Report_Data]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Report_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Report_Data] [xml] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Report_Data] ADD CONSTRAINT [PK_Applicant_Report_Data] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID], [Scoring_Version], [Report_ID]) ON [PRIMARY]
GO
