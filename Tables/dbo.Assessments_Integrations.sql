CREATE TABLE [dbo].[Assessments_Integrations]
(
[Assessment_ID] [tinyint] NOT NULL,
[Integration_ID] [tinyint] NOT NULL,
[Active] [bit] NULL,
[Assessment_Package_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assessments_Integrations] ADD CONSTRAINT [PK_Assessments_Integrations] PRIMARY KEY CLUSTERED  ([Assessment_ID], [Integration_ID], [Assessment_Package_ID]) ON [PRIMARY]
GO
