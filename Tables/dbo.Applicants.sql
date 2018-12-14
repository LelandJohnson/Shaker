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
