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
