CREATE TABLE [dbo].[Applicant_Item_Types]
(
[Item_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Item_Types] ADD CONSTRAINT [PK_Applicant_Item_Types] PRIMARY KEY CLUSTERED  ([Item_Type]) ON [PRIMARY]
GO
