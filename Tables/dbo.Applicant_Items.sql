CREATE TABLE [dbo].[Applicant_Items]
(
[Assessment_ID] [tinyint] NOT NULL,
[Item_ID] [smallint] NOT NULL,
[Data_Title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Item_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display_Prompt] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display_Text] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Item_Parameters] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Item_RegExpValidate] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Help_Text] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Report_Label] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display_Order] [real] NULL,
[Display_Page] [real] NULL,
[Required] [bit] NULL,
[Allow_Export] [bit] NULL,
[Allow_Filter] [bit] NULL,
[Allow_Search] [bit] NULL,
[Contingent_Display] [bit] NULL,
[Contingent_Item_ID] [tinyint] NULL,
[Contingent_Value] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_Posted] [bit] NULL,
[EEOC] [bit] NULL,
[Conceal_Display] [bit] NULL,
[Integration_XML_CDATA] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_XML_Node] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_XML_NodeChildren] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_XML_Attribute] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_Form_Name] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_Form_Field] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Integration_XML_AttributeValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Items] ADD CONSTRAINT [PK_Applicant_Items] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Item_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Items] ADD CONSTRAINT [FK_Applicant_Items_Applicant_Item_Types] FOREIGN KEY ([Item_Type]) REFERENCES [dbo].[Applicant_Item_Types] ([Item_Type])
GO
