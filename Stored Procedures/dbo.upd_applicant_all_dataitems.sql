SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	write Applicant_Data values
--				about applicant.
--				@AD_XML parameter is xml containing applicant data
--				items from signin form in this format:
--					<otherData>
--					  <Data_Title>value</Data_Title>
--					  <Data_Title>value</Data_Title>
--					</otherData>
--				(Data_Title corresponds to item's Data_Title field in Applicant_Items)
--
-- History:		v1
--				v2 - fixed bug to support more than one assessment.
--				v3 - added optional req id to store user-entered data items in integrated environment
-- =============================================
create PROCEDURE [dbo].[upd_applicant_all_dataitems]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint = 1,
	@Session_ID tinyint,
    @AD_XML XML,
	@Requisition_ID VARCHAR(50) = NULL
	)
	
AS
set nocount off

--for each item, call upd_applicant_dataitem which does the insert/update
--via tvf

create table #itempairs (Data_Title varchar(50), Item_Value nvarchar(255), Item_ID smallint)

insert into #itempairs (Data_Title, Item_Value, Item_ID) 
SELECT ADValues.Item.value('local-name(.)','VARCHAR(50)'), ADValues.Item.value('.','VARCHAR(255)'), Applicant_Items.Item_ID
FROM @AD_XML.nodes('/otherData/*') as ADValues(Item) 
inner join Applicant_Items on Applicant_Items.Data_Title like ADValues.Item.value('local-name(.)','VARCHAR(50)')
          and Applicant_Items.Assessment_ID = @Assessment_ID




merge   Applicant_Data as target
using   #itempairs as source 
        on target.Applicant_ID = @Applicant_ID and
           target.Assessment_ID = @Assessment_ID and
           target.Item_ID = source.Item_ID and
           target.Session_ID = @Session_ID and
           target.Requisition_ID = ISNULL(@Requisition_ID, '')
        when matched then
                update set Item_Value = source.Item_Value
        when not matched then
                insert (Applicant_ID, Assessment_ID, Item_ID, Session_ID, Requisition_ID, Item_Value) 
                values(@Applicant_ID, @Assessment_ID, source.Item_ID, @Session_ID, ISNULL(@Requisition_ID, ''), source.Item_Value );


drop table #itempairs
GO
