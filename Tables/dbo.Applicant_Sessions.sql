CREATE TABLE [dbo].[Applicant_Sessions]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Content_Version] [real] NULL,
[Start_Date] [datetime] NULL,
[Completion_Date] [datetime] NULL,
[Last_Activity_Date] [datetime] NULL,
[Elapsed_Time] [int] NULL,
[Question_Time] [int] NULL,
[Scoring_Version] [real] NULL,
[Classification_ID] [tinyint] NULL,
[Status_Code] [smallint] NULL,
[Integration_Flag] [tinyint] NULL,
[Section_Time_Remaining] [smallint] NULL,
[Bookmark] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Results_Overall] [tinyint] NULL,
[Results_OtherValue1] [tinyint] NULL,
[Results_OtherValue2] [tinyint] NULL,
[Language_Code] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Alt_Version] [tinyint] NULL,
[Location_ID] [smallint] NULL,
[Applicant_Start_Date] [datetime] NULL,
[Retake_Date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Sessions] ADD CONSTRAINT [PK_Applicant_Sessions] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Sessions] ADD CONSTRAINT [FK_Applicant_Sessions_Applicants] FOREIGN KEY ([Applicant_ID]) REFERENCES [dbo].[Applicants] ([Applicant_ID])
GO
ALTER TABLE [dbo].[Applicant_Sessions] ADD CONSTRAINT [FK_Applicant_Sessions_Assessments] FOREIGN KEY ([Assessment_ID]) REFERENCES [dbo].[Assessments] ([Assessment_ID])
GO
