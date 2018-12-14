CREATE TABLE [dbo].[Customers]
(
[Customer_Name] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer_Code] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer_ID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED  ([Customer_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Lookup code in url string', 'SCHEMA', N'dbo', 'TABLE', N'Customers', 'COLUMN', N'Customer_Code'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer display name', 'SCHEMA', N'dbo', 'TABLE', N'Customers', 'COLUMN', N'Customer_Name'
GO
