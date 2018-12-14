CREATE TABLE [dbo].[Customer_Assessments]
(
[Customer_ID] [smallint] NOT NULL,
[Assessment_ID] [tinyint] NOT NULL,
[Active] [bit] NULL,
[License_Applicants_Remaining] [int] NULL,
[License_EndDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Assessments] ADD CONSTRAINT [PK_Customer_Assessments] PRIMARY KEY CLUSTERED  ([Customer_ID], [Assessment_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Assessments] ADD CONSTRAINT [FK_Customer_Assessments_Customers] FOREIGN KEY ([Customer_ID]) REFERENCES [dbo].[Customers] ([Customer_ID])
GO
