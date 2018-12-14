CREATE TABLE [dbo].[Administrators]
(
[Admin_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[First_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Initials] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL,
[Password] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Login_Date] [datetime] NULL,
[Password_Date] [datetime] NULL,
[Consecutive_Fails] [tinyint] NULL,
[PW_Hist_1] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PW_Hist_2] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PW_Hist_3] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PW_Hist_4] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Locked_Until_Date] [datetime] NULL,
[Creation_Date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrators] ADD CONSTRAINT [PK_Administrators] PRIMARY KEY CLUSTERED  ([Admin_ID]) ON [PRIMARY]
GO
