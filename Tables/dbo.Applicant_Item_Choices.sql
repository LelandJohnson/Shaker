CREATE TABLE [dbo].[Applicant_Item_Choices]
(
[Assessment_ID] [tinyint] NOT NULL,
[Item_ID] [smallint] NOT NULL,
[Choice_ID] [tinyint] NOT NULL,
[Store_Value] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display_Text] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display_Order] [real] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Item_Choices] ADD CONSTRAINT [PK_Applicant_Item_Choices] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Item_ID], [Choice_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant_Item_Choices] ADD CONSTRAINT [FK_Applicant_Item_Choices_Applicant_Items] FOREIGN KEY ([Assessment_ID], [Item_ID]) REFERENCES [dbo].[Applicant_Items] ([Assessment_ID], [Item_ID])
GO
