CREATE TABLE [dbo].[Locations]
(
[Location_ID] [smallint] NOT NULL,
[Parent_Location_ID] [smallint] NULL,
[Location_Desc] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location_ABBR] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location_Type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [smallint] NULL,
[Lineage] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Locations] ADD CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED  ([Location_ID]) ON [PRIMARY]
GO
