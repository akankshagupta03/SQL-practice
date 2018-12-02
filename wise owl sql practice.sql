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



use doctorwho
go

select [AuthorName] ,[Title],[EpisodeType]from [dbo].[tblAuthor]  a join [dbo].[tblEpisode] b on a.[AuthorId]=b.[AuthorId]
where episodetype like '%special%'
order by [Title]

select [DoctorName],[Title],[AuthorName], [EnemyName],(len([DoctorName])+len([AuthorName])+len([Title])+len([EnemyName]))Totallength
from [dbo].[tblDoctor]  a join [dbo].[tblEpisode] b on a.[DoctorId]=b.[DoctorId] join 
[dbo].[tblAuthor] c on b.AuthorId=c.AuthorId join [dbo].[tblEpisodeEnemy] d on b.[EpisodeId]=d.EpisodeId join [tblEnemy] e on e.EnemyId=d.EnemyId
where (len([DoctorName])+len([AuthorName])+len([Title])+len([EnemyName])) <40 order by totalLength asc


select [AuthorName], [EnemyName] from [dbo].[tblAuthor] a join [tblEpisode] b on a.[AuthorId]=b.AuthorId 
join[dbo].[tblEpisodeEnemy] c on b.[EpisodeId]=c.EpisodeId join [tblEnemy] d on c.EnemyId=d.EnemyId
where [EnemyName]='Daleks'

select [CompanionName], a.[CompanionId],[EpisodeId]from [dbo].[tblCompanion] a left outer join [dbo].[tblEpisodeCompanion]b 
on a.[CompanionId]=b.CompanionId where [EpisodeId] is null

select [AuthorName],count([EpisodeId]) episodes , min([EpisodeDate]) earliest,max([EpisodeDate]) latest from [dbo].[tblAuthor] a join [tblEpisode] b on a.[AuthorId]=b.AuthorId 
group by [AuthorName] order by episodes desc

select [AuthorName] , DoctorName, count(b.EpisodeId) episodes from [dbo].[tblAuthor] a join [dbo].[tblEpisode] b on a.[AuthorId]=b.[AuthorId] join tblDoctor c on b.DoctorId=c.DoctorId 
group by [AuthorName] ,DoctorName having count(b.EpisodeId)>5 order by episodes desc


select year(EpisodeDate) episodeyear, [EnemyName], count(a.EpisodeId) episodes from  [dbo].[tblEpisode] a join tblDoctor c on a.DoctorId=c.DoctorId 
join [tblAuthor] b on a.[AuthorId]=b.AuthorId 
join[dbo].[tblEpisodeEnemy] d on a.[EpisodeId]=d.EpisodeId join [tblEnemy] e on d.EnemyId=e.EnemyId
where year([BirthDate]) < 1970
group by [EnemyName],year(EpisodeDate) having count(a.EpisodeId)>1


