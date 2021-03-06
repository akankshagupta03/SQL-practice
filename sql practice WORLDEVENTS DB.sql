use worldevents
go

select * from tblEvent order by EventDate desc

select Top 5 eventname as What, EventDetails as Details from tblEvent order by EventDate desc

select top 3 CategoryID, CategoryName from tblCategory order by CategoryName desc

select Top 2 eventname as What, EventDate as "When" from tblEvent order by EventDate desc

select top 2 eventname as What, EventDate as "When" from tblEvent order by EventDate 

select * from tblCategory
select * from tblCountry
select * From tblEvent
select * from tblcontinent
select eventname, eventid from tblCategory a join tblEvent B on a.CategoryID=b.categoryid where a.CategoryID=11 order by CategoryName desc

select eventname ,eventdetails, EventDate from tblCategory a join tblEvent B on a.CategoryID=b.categoryid join tblCountry c on b.CountryID=c.CountryID
where 
(a.CategoryID=4 or 
(c.CountryID  in (8,22,30,35) or (b.eventdetails) like '% Water %' ) )and 
yeAR(EventDate)>1970
order by EventDate 

select eventname as What, EventDate as "When" from tblEvent where 
datepart(yyyy,EventDate) = 2005
and datepart(month,EventDate) =2

select *  from tblCountry a join tblEvent B on a.CountryID=b.CountryID 
select * from tblCategory a join tblEvent B on a.CategoryID=b.categoryid join tblCountry c on b.CountryID=c.CountryID
where
((eventdetails) not like ('%space%') and
(eventname) not like ('%space%'))
and
b.CountryID=13

select * from tblCategory a join tblEvent B on a.CategoryID=b.categoryid 
where
((eventdetails) not like ('%war%') and

(eventdetails) not like ('%death%') )
and
(b.CategoryID in (5,6))

select * from  tblEvent  
where (eventname)like ('%teletubbies%') or
(eventname)like ('%pandy%') 

select eventname,len(eventname) as length from  tblEvent  order by length

select eventname+ '('+ 'category '+cast(categoryid as varchar) +')' as 'event(category)' ,eventdate from  tblCountry a join tblEvent B on a.CountryID=b.CountryID 
 
where a.CountryID=1
select * from tblCountry
select [ContinentID]
      ,[ContinentName]
      ,ISNULL(Summary,'NO SUMMARY')as 'Summary using ISNULL', COALesce(Summary,'NO SUMMARY')as 'Summary using COALesce',
	 ( case when Summary is  null then 'NO SUMMARY' else summary end) as 'Summary using case' 
	  from tblcontinent

	  select countryname, ( case when (a.continentid in (1,3) and continentname in ('Europe','Asia')) then 'Eurasia'
	  when  (a.continentid in (5,6) or continentname in ('North America','South America') )then 'Americas'
	    when  (a.continentid in (2,4) or continentname in ('Africa ','Australasia') )then 'Somewhere hot'
		when  (a.continentid = 7 or continentname = ('Antarctica')) then 'Somewhere cold'
		else 'Somewhere else' end
		) as 'CountryLocation' from tblcontinent a join tblCountry b on a.continentid=b.continentid
		order by CountryLocation desc

		SELECT [Country]
      ,[KmSquared], abs(KmSquared/20761) as Walesunit, (KmSquared%20761)
	  as 'AreaLeftOver',
	  (case when abs(KmSquared/20761)>0 then ((cast (abs(KmSquared/20761) as varchar))+'x Wales plus '+ (cast(KmSquared%20761 as varchar)) + ' sq km.')
	  else 'Smaller than Wales' end ) as Walescomparison
  FROM [WorldEvents].[dbo].[CountriesByArea]
  order by abs(KmSquared-20761) 

select eventname,eventdate, charindex('this',eventdetails,1) as thispoisition, charindex('that',eventdetails,1) thatposition, 
abs(charindex('this',eventdetails,1)-charindex('that',eventdetails,1)) offset
from  tblEvent 
where eventdetails like '%this%that%' order by eventname

select eventname, eventdate as notformatted, format(eventdate,'dd/MM/yyyy') as usingformat,
convert(varchar,eventdate,3) as usingconvert from tblEvent where year(eventdate)=1978 
order by eventdate

select eventname, format(eventdate,'dd MMM yyyy') as eventdate
, datediff(day,eventdate,'1964-03-04') as daysoffset,
abs(datediff(day,eventdate,'1964-03-04')) as daysdifference
from tblEvent order by abs(datediff(day,eventdate,'1964-03-04'))

select eventname, eventdate,DATENAME(weekday,eventdate) as dayofweek,datepart(day,eventdate) as daynumber from tblEvent


select eventname,  
(case when(( datepart(day,eventdate) = 1 or datepart(day,eventdate) like '_1%') and datepart(day,eventdate) != 11) then DATENAME(weekday,eventdate)+ ' ' + cast(datepart(day,eventdate)as varchar)+ 'st' + ' ' + DATENAME(month,eventdate)+ ' ' + cast(year(eventdate) as varchar) 
when ( (datepart(day,eventdate) like '_2%' or datepart(day,eventdate) = 2) and datepart(day,eventdate) != 12)  then (DATENAME(weekday,eventdate)+ ' ' + cast(datepart(day,eventdate)as varchar)+ 'nd'+ ' ' + DATENAME(month,eventdate)+ ' ' + cast( year(eventdate)as varchar)) 
when ((datepart(day,eventdate) like '_3%' or datepart(day,eventdate) = 3)and datepart(day,eventdate) != 13) then (DATENAME(weekday,eventdate)+ ' ' + cast(datepart(day,eventdate)as varchar)+ 'rd' + ' ' + DATENAME(month,eventdate)+ ' ' + cast( year(eventdate)as varchar)) 
else (DATENAME(weekday,eventdate)+ ' ' + cast(datepart(day,eventdate)as varchar)+ 'th' + ' ' +DATENAME(month,eventdate)+ ' ' + cast(year(eventdate)as varchar)) 
end ) as fullname from tblEvent

SELECT b.CountryName AS country, a.EventName AS What, a.EventDate AS [When]
FROM   tblEvent AS a INNER JOIN
             tblCountry AS b ON a.CountryID = b.CountryID
ORDER BY [When] asc

select eventname ,eventdetails,[CountryName] ,[ContinentName] from tblCountry a join tblEvent B on a.CountryID=b.CountryID join tblContinent c on a.ContinentID=c.ContinentID
where [CountryName]= 'Russia' or [ContinentName] ='Antarctic'

select CategoryName from tblCategory a full outer join 
tblEvent B on a.CategoryID=b.categoryid where EventDate is null order by EventDate desc

SELECT b.CountryName, [EventName]
FROM   tblEvent AS a full outer JOIN
             tblCountry AS b ON a.CountryID = b.CountryID where [EventName] is null


select A.[FamilyName], ISnull(case when b.familyname= 'All categories' then ' ' else
'All categories > 'end + b.FamilyName + '>' + a.FamilyName, 'All categories') as FamilyPAth
 from [dbo].[tblFamily] A left join [dbo].[tblFamily] B
on b.[FamilyID]=a.[ParentFamilyId] 
Order by a.FamilyName

select a.[CategoryName],count([EventID]) events from tblCategory a  join 
tblEvent B on a.CategoryID=b.categoryid group by a.[CategoryName] order by events desc

select count([EventID]) events, min([EventDate]) earliest, max([EventDate]) latest from tblEvent

select [CountryName] ,[ContinentName],count(EventID) events from tblCountry a join tblEvent B on a.CountryID=b.CountryID join tblContinent c on a.ContinentID=c.ContinentID
group by [CountryName] ,[ContinentName] having [ContinentName] !='Europe' and count(EventID) >5
order by [CountryName]


select SUBSTRING(a.[CategoryName],1,1) CategoryiNITIAL, count([EventID]) events, AVG(len(eventname)) avglength from tblCategory a  join 
tblEvent B on a.CategoryID=b.categoryid group by SUBSTRING(a.[CategoryName],1,1) order by CategoryiNITIAL asc


select (case when year(eventdate) like '17%' then '18th century' when
year(eventdate) like '18%' then '19th century'
when year(eventdate) like '19%' then '20th century'
when year(eventdate) like '20%' then '21st century' else null end) century, count([EventID]) events from tblCategory a  join 
tblEvent B on a.CategoryID=b.categoryid
group by cube(case when year(eventdate) like '17%' then '18th century' when
year(eventdate) like '18%' then '19th century'
when year(eventdate) like '19%' then '20th century'
when year(eventdate) like '20%' then '21st century' else null end) order by century asc

create view vwEverything as
select [CategoryName], [CountryName] ,[ContinentName] , eventname , EventDate from tblCategory a join tblEvent B on a.CategoryID=b.categoryid join tblCountry c on b.CountryID=c.CountryID
join tblContinent d on d.ContinentID=c.ContinentID

select count(eventname) events,[CategoryName] from vwEverything	where [ContinentName]='Africa'
group by [CategoryName] order by events desc

select [EventName],[EventDate],[CountryName] from tblevent a join [dbo].[tblCountry] b on a.[CountryID]=b.[CountryID] where
eventdate > (select max (eventdate) from tblevent 
where countryid=21
)
order by eventdate desc

select [EventName] from tblevent where len([EventName])> (select  AVG(len(eventname)) avglenth from tblevent)



Select b.[ContinentName], a.[EventName] 
from tblevent a 
     join [dbo].[tblCountry] c
       on a.[CountryID] = c.[CountryID] 
     join [dbo].[tblContinent] b
       on c.[ContinentID] = b.[ContinentID]
where [ContinentName] in
(
  select top 3 [ContinentName]
  from tblevent a 
       join [dbo].[tblCountry] c
         on a.[CountryID] = c.[CountryID] 
       join [dbo].[tblContinent] b
         on c.[ContinentID] = b.[ContinentID]
  group by [ContinentName]
  order by count(*) 
)  ;




select [CountryName]from tblevent a join[dbo].[tblCountry] c 
on a.[CountryID]=c.[CountryID] 
where [CountryName] in(


select [CountryName], count([EventName])  from tblevent a join[dbo].[tblCountry] c 
on a.[CountryID]=c.[CountryID] group by [CountryName] having count([EventName]) >8)

 

 select eventname,eventdetails 
 FROM tblCountry a
INNER JOIN tblEvent b
ON a.CountryID=b.CountryID
INNER JOIN tblCategory c
ON c.CategoryID=b.CategoryID where 
a.countryid not in (select top 30 countryid from [tblCountry] order by CountryName desc )
and
c.[CategoryID] not in (select top 15 [CategoryID] from [tblCategory] order by CategoryName desc )
ORDER BY EventName DESC


create proc uspCountriesAsia
as


select countryname from tblcountry where countryid=1


exec uspCountriesAsia


----SQL | Variables exercise | Retrieve aggregated data using variables

declare @EarliestDate date
declare @LatestDate date
declare @NumberOfEvents int
declare @EventInfo nvarchar(100) = 'Summary of events'

SELECT   @EarliestDate = (SELECT MIN(eventdate) FROM tblevent) 
        ,@LatestDate = (SELECT MAX(eventdate) FROM tblevent) 
        ,@NumberOfEvents = (SELECT COUNT(eventid) FROM tblevent) 

SELECT   @EventInfo [Title]
        ,@EarliestDate [Earliest Date]
        ,@LatestDate [Latest date]
        ,@NumberOfEvents [Number of Events]




alter proc  spCalculateAge as
declare @Age int
set @Age= (select DateDiff(year,'03/10/1989',GetDate()))

print 'you are ' + cast(@Age as varchar)+ ' years old'

exec spCalculateAge



alter procedure ppp
(@CategoryName nvarchar(255)=NULL,
@After datetime=NULL OUT,
@CategoryId int =NULL OUT)
as
begin
select @CategoryName=categoryname, @After=min([EventDate]), @CategoryId=count(a.categoryid)  from
[dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
where  (@CategoryName IS NULL OR CategoryName LIKE '%' + @CategoryName + '%')and eventdate<= @After or 
a.categoryid=@CategoryId group by CategoryName


end


declare @CatId int, @after1 date
exec ppp @CategoryName='death', @after=@after1 output,@CategoryId= @CatId output
select @CatId as CategoryId,@after1 as eventdate

alter procedure aku
(@CategoryName varchar(255)=NULL,
@After datetime=NULL OUT,
@CategoryId int =NULL OUT)
as
begin
select  @After=min([EventDate]), @CategoryId=(a.categoryid)  from
[dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
where  (@CategoryName IS NULL OR CategoryName LIKE '%' + @CategoryName + '%')


end

declare @date1 date,@id int
exec aku 'death', @after= @date1 output,@categoryid=@id output
select @date1 as eventdate, @id as categoryid


select [CategoryName], min(eventdate),count(a.categoryid) from
[dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
where 
--a.categoryid=16
(CategoryName IS NULL OR CategoryName LIKE '%death%') or eventdate='19900101'
group by [CategoryName]

select [CategoryName], min(eventdate),count(a.categoryid) from
[dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
where 

--(CategoryName IS NULL OR CategoryName LIKE '%death%') and 
eventdate<=null
or a.categoryid =16
group by [CategoryName],(eventdate)

select categoryname, min([EventDate]), count(a.categoryid)  from
[dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
where  (CategoryName IS NULL OR CategoryName LIKE  '%death$%')and eventdate<= 1909 or 
a.categoryid=null group by CategoryName

---SQL | Looping exercise | Basic loop to count events for each year

DECLARE @Counter INT = 1989
DECLARE @EndValue INT = year(GetDate())
declare @noofevents int
WHILE @Counter <=@EndValue

BEGIN
set @noofevents =(select count(eventid) from tblevent where year(eventdate)=@Counter )

print cast(@noofevents as varchar(10))+' events occurred in ' + cast(@Counter as varchar(10))

SET @Counter = @Counter + 1 

END
---SQL | Parameters and return values exercise | Default values in parameters

alter procedure uspContinentEvents
(@continentname varchar(200) =null,
@startdate date =null,
@enddate date =null)
as
begin
If @continentname is null  

select continentname, eventname, eventdate from tblevent a join tblcountry b on a.CountryID=b.CountryID join
tblContinent c on b.ContinentID=c.ContinentID 
else

select continentname, eventname, eventdate from tblevent a join tblcountry b on a.CountryID=b.CountryID join
tblContinent c on b.ContinentID=c.ContinentID where continentname=@continentname and eventdate between @startdate and 
@enddate
end

exec uspContinentEvents @continentname='Asia', @startdate='1990-01-01',@enddate='2000-01-01'
--SQL | Parameters and return values exercise | Outputting list variables
ALTER PROC spContinentName
	@continentOutput varchar(200) out

AS

BEGIN
	declare @commaSperatedContinantName varchar(200)
	set @commaSperatedContinantName = ''
 select 
	@commaSperatedContinantName =  @commaSperatedContinantName + continentname + ', '
 from 
	tblevent a join tblcountry b 
 on 
	a.CountryID=b.CountryID join
	tblContinent c 
 on b.ContinentID=c.ContinentID 
 group by 
	continentname 
 having 
	count(eventid)>50

	set @continentOutput = LEFT (@commaSperatedContinantName,len(@commaSperatedContinantName)-1)
END

declare @outputMain varchar(200)
EXEC spContinentName @outputMain out
select @outputMain as cotinenet_name
---SQL | Parameters and return values exercise | Using Return Values

alter procedure spcalcdifference

as
begin 
declare @minlength int, @maxlength int, @difference int
set @minlength=(select min(len(eventname)) from tblevent)
set @maxlength=(select max(len(eventname)) from tblevent)

select @difference=@minlength-@maxlength
return @difference
end

declare @output int
exec @output = spcalcdifference	
select @output
---SQL | Scalar functions exercise | Create a scalar function to count the total number of letters

create function fnLetterCount(@First varchar(50),
@Second varchar(100))

returns int
begin

declare @eventlength int,@evtdtllen int,@sum int
set @eventlength=(select len(eventname) from tblevent where eventname like '%'+@First+'%' and eventdetails like '%'+@Second+'%')
set @evtdtllen=(select len(EventDetails) from tblevent where eventname like '%'+@First+'%' and eventdetails like '%'+@Second+'%')
set @sum=@eventlength+@evtdtllen

return @sum
end

select eventname,eventdetails, eventdate, dbo.fnLetterCount(eventname,eventdetails) as totaletters from tblevent
order by totaletters asc

create table summary_data(summaryitem varchar(250),countevents smallint)
truncate table summary_data
insert into summary_data(summaryitem,countevents) 
select 'last millennium',count(eventid)  from [dbo].[tblEvent] where eventdate< = '2000-01-01'
union
select 'this millennium',count(eventid)  from [dbo].[tblEvent] where eventdate> = '2000-01-01'
union
select continentname,count(eventid)  from tblevent a join tblcountry b 
 on 
	a.CountryID=b.CountryID join
	tblContinent c 
 on b.ContinentID=c.ContinentID  

 group by 
	continentname 
	union
	select CountryName,count(eventid)  from tblevent a join tblcountry b 
 on 
	a.CountryID=b.CountryID
 group by 
	CountryName 
	select * from summary_data order by 2 desc



	alter function Annualevents(@eventyear datetime)
	returns table
	as
	return
	select eventname, categoryname, countryname
	from [dbo].[tblEvent] a join [dbo].[tblCategory] b on a.[CategoryID]=b.[CategoryID]
	join [dbo].[tblCountry] c on a.[CountryID]=c.[CountryID]
	where year(eventdate) = @eventyear
	
	select * from  Annualevents(2000)

----SQL | Derived tables and CTEs exercise | Create a CTE to make it easier to group by an expression
	with ThisAndThat as
	(
	select (case when eventdetails like '%this%' then 1 else 0 end) Ifthis,
	(case when eventdetails like '%that%'then 1 else 0 end) Ifthat, count(eventid) as 'numberofevents'
	from tblEvent
	group by (case when eventdetails like '%this%'then 1 else 0 end),
	(case when eventdetails like '%that%'then 1 else 0 end)
	)select * from ThisAndThat

	--SQL | Dynamic SQL exercise | Basic dynamic SQL to pass in table name
	alter proc dynamicsql (@tblevent VARCHAR(MAX) )
	as begin
	DECLARE @SQL VARCHAR(MAX) =

'SELECT * FROM ' + @tblevent
exec(@SQL)
end		
	
	exec dynamicsql 'tblevent'

--SQL | Dynamic SQL exercise | Dynamic SQL
	alter proc spselect (@columns varchar(100),
	@tablename varchar(50),
	@numberrows 	int,
	@ordercolumn varchar(50))

	as 
	begin
	declare @sqlstring VARCHAR(MAX)= 'select top ' +cast(@numberrows as varchar(10))+@columns+' from '+@tablename+' order by ' +@ordercolumn+ ' desc'
	exec (@sqlstring)
	end

	exec spselect @tablename='tblevent',@ordercolumn='EventDetails',@columns=' EventDetails, eventid ',@numberrows=5


	alter trigger trg1 on [tblCountry]
	after insert,update
	as

	DECLARE @INS int, @DEL int

SELECT @INS = COUNT(*) FROM INSERTED
	SELECT @DEL = COUNT(*) FROM DELETED

IF @INS > 0 AND @DEL > 0


begin
	insert into tblechange 
	SELECT 'New Values', getdate() FROM INSERTED
	
	insert into tblechange 
	select 'Old Values', getdate() from deleted
	end
	ELSE 
BEGIN

    -- a new record was inserted.

    INSERT INTO tblechange
    SELECT 'Insert', getdate() FROM INSERTED
	end

	drop table tblechange
	create table tblechange ([CountryName] varchar(100),Change varchar(100))

	select 
	insert into [tblCountry]

update [tblCountry]	set [CountryName]= 'Viet nam' 
where [CountryName]='Vietnam'

select * FROM INSERTED 
truncate table tblechange1
select * from tblechange1
select * from 
[tblCountry]
where [CountryName]='Vietnam'



	alter trigger trg1 on [tblCountry]
	for insert
	as

	DECLARE @INS int, @DEL int

SELECT @INS = COUNT(*) FROM INSERTED
	SELECT @DEL = COUNT(*) FROM DELETED

IF @INS > 0 AND @DEL > 0


begin
	insert into tblechange1 
	SELECT CountryName,'New Values' FROM INSERTED
	
	insert into tblechange1 
	select CountryName,'Old Values' from deleted
	end
	ELSE 
BEGIN

    -- a new record was inserted.

    INSERT INTO tblechange1
    SELECT CountryName,'New Values' FROM INSERTED
	end






	exec sp_helpindex tblevent