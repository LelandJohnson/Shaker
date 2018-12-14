CREATE TABLE [dbo].[Export_Data]
(
[Applicant_ID] [int] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Session_ID] [tinyint] NOT NULL,
[Export_ID] [varchar] (99) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Scoring_Version] [real] NOT NULL,
[Data_Row] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Export_Data] ADD CONSTRAINT [PK_Export_Data] PRIMARY KEY CLUSTERED  ([Applicant_ID], [Assessment_ID], [Session_ID], [Export_ID], [Scoring_Version]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Export_Data] ADD CONSTRAINT [FK_Export_Data_Applicant_Sessions1] FOREIGN KEY ([Applicant_ID], [Assessment_ID], [Session_ID]) REFERENCES [dbo].[Applicant_Sessions] ([Applicant_ID], [Assessment_ID], [Session_ID])
GO
ALTER TABLE [dbo].[Export_Data] ADD CONSTRAINT [FK_Export_Data_Export_Definitions] FOREIGN KEY ([Assessment_ID], [Export_ID], [Scoring_Version]) REFERENCES [dbo].[Export_Definitions] ([Assessment_ID], [Export_ID], [Scoring_Version])
GO
