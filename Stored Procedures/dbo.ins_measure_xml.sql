SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		jw
-- Description:	store measures
--				submitted via xml:
--				@NS_XML parameter is xml containing measures to write
--
--				<x>
--				 <m id="sj21_Entry_M">3</m>
--				 <m id="KBps">564</m>
--				</x>
--
--
-- History:		v1 initial (for non-modular db)
--				*needs smallint capping logic for cumulative measures
-- =============================================
CREATE PROCEDURE [dbo].[ins_measure_xml]
	
	(
	@Applicant_ID int,
	@Assessment_ID tinyint,
	@Session_ID tinyint,
    @NS_XML xml --NewSubmit XML
	)
	
AS
set nocount off



create table #itempairs (Item_Value nvarchar(4000), Measure_ID smallint, Textual bit, Cumulative bit)

insert into #itempairs (Item_Value, Measure_ID, Textual, Cumulative) 
SELECT --Item.value('./@id', 'varchar(30)'),    --id="xxx" name
	   Item.value('.', 'nvarchar(4000)'),	   --value to submit
	   m.Measure_ID,							   --measureid from measures table
	   ISNULL(m.Textual, 0),					--"textual" bit null=false if still null
	   ISNULL(m.Cumulative, 0)					--same with cumulative				  
FROM @NS_XML.nodes('x/*') as NSValues(Item) 
     inner join Measures m on m.Measure_Name like NSValues.Item.value('./@id', 'varchar(30)')
						  AND m.Assessment_ID = @Assessment_ID --later content ver


--  select * from #itempairs --debug display
 

----do insert/update


MERGE dbo.Applicant_Measures_Num AS target
using   #itempairs as source 
ON target.Applicant_ID = @Applicant_ID AND
   target.Assessment_ID = @Assessment_ID AND
   target.Session_ID = @Session_ID AND 
   target.Measure_ID = source.Measure_ID

        when matched and source.Textual=0 then		--textual condition (comparison to a constant) must be specified in when clause, not ON clause
												
                update 
                  SET [Value] =
                    CASE when source.Cumulative = 1 THEN			--add to previous value
                     [Value] + CAST(source.Item_Value as smallint)
                    ELSE  
                     CAST(source.Item_Value as smallint)
                    END
        
        when not matched by target and source.Textual=0 then
        
                insert (Applicant_ID, Assessment_ID, Session_ID, Measure_ID, Value) 
                values(@Applicant_ID, @Assessment_ID, @Session_ID, source.Measure_ID, CAST(source.Item_Value as smallint) );



--same but for text measures, without cumulative ability or conversion to smallint. (different table as target needs separate MERGE statement)
MERGE dbo.Applicant_Measures_Text AS target
using   #itempairs as source 
ON target.Applicant_ID = @Applicant_ID AND
   target.Assessment_ID = @Assessment_ID AND
   target.Session_ID = @Session_ID AND 
   target.Measure_ID = source.Measure_ID
   
        when matched and source.Textual=1 then	
												
                update SET [Value] = source.Item_Value
        
        when not matched by target and source.Textual=1 then
        
                insert (Applicant_ID, Assessment_ID, Session_ID, Measure_ID, Value) 
                values(@Applicant_ID, @Assessment_ID, @Session_ID, source.Measure_ID, source.Item_Value );

   

drop table #itempairs

GO
