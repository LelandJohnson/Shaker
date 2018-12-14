CREATE TABLE [dbo].[AspNetUserPreviousPasswords]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CreatedOn] [datetimeoffset] NOT NULL CONSTRAINT [DF__AspNetUse__Creat__1DB06A4F] DEFAULT (getutcdate()),
[PasswordHash] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserId] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserPreviousPasswords] ADD CONSTRAINT [PK_UserPassword] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserPreviousPasswords] ADD CONSTRAINT [FK_UserPassword_VjtAdministrator_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
GO
