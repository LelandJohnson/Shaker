CREATE TABLE [dbo].[Branding]
(
[Branding_ID] [tinyint] NOT NULL,
[Logo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Style_Sheet] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Color_Scheme] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Web_Banner] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Privacy_Version] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Terms_Version] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Branding] ADD CONSTRAINT [PK_Branding] PRIMARY KEY CLUSTERED  ([Branding_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Skin to apply to assessment when multiple brands/companies exist for one customer database', 'SCHEMA', N'dbo', 'TABLE', N'Branding', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flash linkage to branded skin', 'SCHEMA', N'dbo', 'TABLE', N'Branding', 'COLUMN', N'Color_Scheme'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Logo file for admin and reports', 'SCHEMA', N'dbo', 'TABLE', N'Branding', 'COLUMN', N'Logo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Which Privacy Policy html file to display', 'SCHEMA', N'dbo', 'TABLE', N'Branding', 'COLUMN', N'Privacy_Version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Which Terms of Use html file to display', 'SCHEMA', N'dbo', 'TABLE', N'Branding', 'COLUMN', N'Terms_Version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Top of HTML pages to display', 'SCHEMA', N'dbo', 'TABLE', N'Branding', 'COLUMN', N'Web_Banner'
GO
