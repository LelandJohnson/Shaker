CREATE TABLE [dbo].[AspNetUserLogins]
(
[LoginProvider] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderKey] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderDisplayName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserId] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [PK_IdentityUserLogin<string>] PRIMARY KEY CLUSTERED  ([LoginProvider], [ProviderKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_IdentityUserLogin<string>_VjtAdministrator_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
GO
