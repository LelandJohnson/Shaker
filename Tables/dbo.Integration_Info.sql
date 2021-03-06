CREATE TABLE [dbo].[Integration_Info]
(
[Integration_System] [tinyint] NOT NULL,
[Product_Name] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Contact_Info] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Integration_Info] ADD CONSTRAINT [PK_Integration_Info] PRIMARY KEY CLUSTERED  ([Integration_System]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'List of people to contact when integration problems occur', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Info', 'COLUMN', N'Contact_Info'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of ATS vendor, product or company name', 'SCHEMA', N'dbo', 'TABLE', N'Integration_Info', 'COLUMN', N'Product_Name'
GO
