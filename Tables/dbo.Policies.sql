CREATE TABLE [dbo].[Policies]
(
[Policy_ID] [tinyint] NOT NULL,
[Policy_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Selected_Policy] [bit] NULL,
[Max_Password_Age] [int] NULL,
[Min_Password_Length] [tinyint] NULL,
[Min_Number_Letters] [tinyint] NULL,
[Min_Number_Numbers] [tinyint] NULL,
[Min_Number_Special] [tinyint] NULL,
[Require_Mixed_Case] [bit] NULL,
[Max_Account_Inactivity] [int] NULL,
[Max_Session_Inactivity] [int] NULL,
[Max_Session_Length] [int] NULL,
[Max_Consecutive_Fails] [tinyint] NULL,
[Disallow_Prev_Passwords] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Policies] ADD CONSTRAINT [PK_Policies] PRIMARY KEY CLUSTERED  ([Policy_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of prev passwords, or 0 if unused', 'SCHEMA', N'dbo', 'TABLE', N'Policies', 'COLUMN', N'Disallow_Prev_Passwords'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Days of inactivity until account locked', 'SCHEMA', N'dbo', 'TABLE', N'Policies', 'COLUMN', N'Max_Account_Inactivity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Timeout interval, if any', 'SCHEMA', N'dbo', 'TABLE', N'Policies', 'COLUMN', N'Max_Session_Inactivity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'How long before admin re-login', 'SCHEMA', N'dbo', 'TABLE', N'Policies', 'COLUMN', N'Max_Session_Length'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates active policy in use, in the event of multiple policies in db.', 'SCHEMA', N'dbo', 'TABLE', N'Policies', 'COLUMN', N'Selected_Policy'
GO
