CREATE TABLE [dbo].[Applicants]
(
[Applicant_ID] [int] NOT NULL IDENTITY(1, 1),
[Login_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[First_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Middle_Initial] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password_ResetQ] [tinyint] NULL,
[Password_ResetA] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password_Hint] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Other_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer_ID] [smallint] NULL CONSTRAINT [DF_Applicants_Customer_ID] DEFAULT ((1)),
[Password_NonToken] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicants] ADD CONSTRAINT [PK_Applicants] PRIMARY KEY CLUSTERED  ([Applicant_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Applicant login and bio info same across all positions', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique applicant number within database, generated here', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', 'COLUMN', N'Applicant_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email address via contact info if different from Login_ID', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', 'COLUMN', N'Email'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Internal applicants Employee ID', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', 'COLUMN', N'Employee_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Login_ID, possibly different from Email address', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', 'COLUMN', N'Login_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Internal applicants Employee ID', 'SCHEMA', N'dbo', 'TABLE', N'Applicants', 'COLUMN', N'Other_ID'
GO
