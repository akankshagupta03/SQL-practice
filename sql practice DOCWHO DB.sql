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


create view vwSeriesOne as
select * from [dbo].[tblEpisode] where SeriesNumber=1

select * from vwSeriesOne


create view vwEpisodeCompanion as
select [Title], count(c.CompanionId) companions from tblEpisode a join [dbo].[tblEpisodeCompanion] b  on a.EpisodeId=b.EpisodeId 

join  [dbo].[tblCompanion] c on c.[CompanionId]=b.[CompanionId]
group by [Title]
having count(c.CompanionId)=1

create view vwEpisodeSummary as
select a.Title, a.EpisodeId from (
 (SELECT a.Title, COUNT(c.CompanionId) AS companions, a.EpisodeId
FROM   dbo.tblEpisode AS a INNER JOIN
             dbo.tblEpisodeCompanion AS b ON a.EpisodeId = b.EpisodeId INNER JOIN
             dbo.tblCompanion AS c ON c.CompanionId = b.CompanionId where a.EpisodeId=86
GROUP BY a.Title, a.EpisodeId
HAVING (COUNT(c.CompanionId) > 1))
union
(SELECT a.Title, COUNT(c.EnemyId) AS enemies, a.EpisodeId
FROM   dbo.tblEpisode AS a INNER JOIN
             dbo.tblEpisodeEnemy AS b ON a.EpisodeId = b.EpisodeId INNER JOIN
             dbo.tblEnemy AS c ON c.EnemyId = b.EnemyId
GROUP BY a.Title, a.EpisodeId
HAVING (COUNT(c.EnemyId) > 1))) A order by title asc

 
 (select * from [dbo].[vwEpisodeCompanion] a union 
 select * from[dbo].[vwEpisodeenemy] b)
 --b on a.episodeid= b.episodeid
 --where b.episodeid is null order by a.title
 --or b.title is null 
 order by a.episodeid desc

 select
    F.episodeid
from
    (SELECT a.Title, COUNT(c.EnemyId) AS enemies, a.EpisodeId
FROM   dbo.tblEpisode AS a INNER JOIN
             dbo.tblEpisodeEnemy AS b ON a.EpisodeId = b.EpisodeId INNER JOIN
             dbo.tblEnemy AS c ON c.EnemyId = b.EnemyId
GROUP BY a.Title, a.EpisodeId
HAVING (COUNT(c.EnemyId) > 1)) F
where
  not  exists
    (select 1 from (SELECT a.Title, COUNT(c.CompanionId) AS companions, a.EpisodeId
FROM   dbo.tblEpisode AS a INNER JOIN
             dbo.tblEpisodeCompanion AS b ON a.EpisodeId = b.EpisodeId INNER JOIN
             dbo.tblCompanion AS c ON c.CompanionId = b.CompanionId where a.EpisodeId=86
GROUP BY a.Title, a.EpisodeId
HAVING (COUNT(c.CompanionId) > 1)) D where F.episodeid=D.episodeid)
create view vwEpisodeSummary as
 select
    a.episodeid, A.Title
from
    [dbo].[vwEpisodeenemy] a 
where
    not exists
    (select 1 from [dbo].[vwEpisodeCompanion] b where a.episodeid=b.episodeid)

	select * from vwEpisodeSummary order by title asc


	create proc spMattSmithEpisodes
	as
	SELECT tblEpisode.EpisodeId, tblEpisode.SeriesNumber, tblEpisode.Title, tblEpisode.EpisodeDate, tblDoctor.DoctorName
FROM   tblDoctor INNER JOIN
             tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId
WHERE (tblDoctor.DoctorName = N'Matt Smith')
ORDER BY tblEpisode.EpisodeDate

exec spMattSmithEpisodes

SELECT tblEpisode.Title, tblEpisode.EpisodeNumber, tblAuthor.AuthorName, tblEpisode.EpisodeDate
FROM   tblAuthor INNER JOIN
             tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE (tblAuthor.AuthorName = N'Steven Moffat')
ORDER BY tblEpisode.EpisodeDate DESC

alter proc P1
as
declare @VAR_name as varchar(10) ='Akanksha',
@var_dob as date ='03 oct 1989',
 @var_pets as int = '3'

select 'my name is ' + @VAR_name + ',I was born on ' + cast( @var_dob as varchar) + ' and I have ' + cast( @var_pets as varchar) + ' pets.'

exec p1

--SQL | Variables exercise | Use variables to show details for a given episode number

declare @Episodeid int = 42

declare @EpisodeName Varchar(200)=(select [Title] from tblepisode where episodeid= @EpisodeId )

declare @NumberCompanions int =(select count([CompanionId] ) from tblepisode a join [dbo].[tblEpisodeCompanion] b on a.[EpisodeId]
=b.[EpisodeId] where a.episodeid= @EpisodeId )

declare @NumberEnemies  int = (select count([EnemyId] ) from tblepisode a join [dbo].[tblEpisodeEnemy] b on a.[EpisodeId]
=b.[EpisodeId] where a.episodeid= @EpisodeId )

SELECT

@EpisodeName as Title,

@EpisodeId as 'Episode id',

@NumberCompanions as 'Number of companions',

@NumberEnemies as 'Number of enemies'



SELECT tblEpisode.EpisodeNumber, tblEpisode.SeriesNumber, tblEpisode.Title
FROM   tblEnemy INNER JOIN
             tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId inner JOIN
             tblEpisode on tblEpisode.EpisodeId = tblEpisodeEnemy.EpisodeId
WHERE [EnemyName] like '%ood%'

alter proc dalek
(@EnemyName varchar(100))
as
begin 

	SELECT tblEpisode.EpisodeNumber,EnemyName, tblEpisode.SeriesNumber, tblEpisode.Title
FROM   tblEnemy INNER JOIN
             tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId inner JOIN
             tblEpisode on tblEpisode.EpisodeId = tblEpisodeEnemy.EpisodeId
WHERE [EnemyName] like '%'+@EnemyName+'%'

end

exec dalek 'Ood'


	SELECT tblEpisode.EpisodeNumber,EnemyName, tblEpisode.SeriesNumber, tblEpisode.Title
FROM   tblEnemy INNER JOIN
             tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId inner JOIN
             tblEpisode on tblEpisode.EpisodeId = tblEpisodeEnemy.EpisodeId
WHERE [EnemyName] = 'The Ood'


create function fnReign(
@firstdate date
,@lastdate date)

returns int
as
begin

declare @datediff int
select @datediff=datediff(day,@firstdate,isnull(@lastdate,getdate()))
return @datediff
end

select DoctorName, [dbo].[fnReign](FirstEpisodeDate,LastEpisodeDate)as [Reign in days] from tblDoctor

----SQL | Parameters and return values exercise | Use parameters in procedures to show a doctor's companions
create procedure spCompanionsForDoctor
(@DoctorName varchar(200))

as
begin
select distinct [CompanionName] from
tblDoctor INNER JOIN
             tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId join [dbo].[tblEpisodeCompanion] c on 
			tblEpisode.[EpisodeId]=c.[EpisodeId] join [dbo].[tblCompanion]d on c.[CompanionId]=d.[CompanionId]
			where tblDoctor.[DoctorName]like '%'+@DoctorName+'%'

			end
			exec spCompanionsForDoctor 'matt'

			exec

select distinct [CompanionName] from
tblDoctor INNER JOIN
             tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId join [dbo].[tblEpisodeCompanion] c on 
			tblEpisode.[EpisodeId]=c.[EpisodeId] join [dbo].[tblCompanion]d on c.[CompanionId]=d.[CompanionId]
			where tblDoctor.[DoctorName]like '%Ecc%'	


			CREATE TABLE tblProductionCompany(

ProductionCompanyId int IDENTITY(1,1) PRIMARY KEY,
ProductionCompanyName varchar(100),
Abbreviation varchar(10))
drop table tblProductionCompany

insert into tblProductionCompany(ProductionCompanyName,Abbreviation) values ('british broadcasting corporation','bbc'),
('canadian broadcasting corporation','cbc')

select * from tblProductionCompany

---SQL | Temporary tables and table variables exercise | Build up a temporary table of doctors, companions and enemies
if object_id('tempdb.dbo.#characters','U') is not null
drop table  #characters



select [CompanionId] as Characterid,[CompanionName] as charactername, 'Companion' as 'characterType' 
into #characters
from [dbo].[tblCompanion]

select * from #characters
SET IDENTITY_INSERT #Characters ON 

insert into #characters (charactername,characterType)
select[EnemyName],'enemy' from [dbo].[tblEnemy]
SELECT * FROM #Characters

ORDER BY CharacterName DESC
---SQL | Derived tables and CTEs exercise | Show companions for specific authors' episodes, using a CTE

with doctorepisodes as(
select[EpisodeId], [Title], [AuthorName] from [dbo].[tblAuthor]a join [dbo].[tblEpisode] b  on a.[AuthorId]=b.[AuthorId]
where [AuthorName] like '%mp%')
select distinct [CompanionName] from doctorepisodes a join [dbo].[tblEpisodeCompanion] b on a.[EpisodeId]=b.[EpisodeId]
join[dbo].[tblCompanion]c on c.[CompanionId]=b.[CompanionId] order by [CompanionName] asc


with episodeyear1 as(
select [SeriesNumber], year([EpisodeDate]) episodeyear ,[EpisodeId],
ROW_NUMBER() OVER (ORDER BY [SeriesNumber]) AS 'RowNumber'from [dbo].[tblEpisode])
select 
[SeriesNumber],episodeyear, [EpisodeId] from episodeyear1
Pivot(count([EpisodeId])for episodeyear in ([2005],[2006],[2007],[2008],[2009],[2010]) ) as pivottable

select [SeriesNumber], year([EpisodeDate]) as episodeyear , [EpisodeId]
from [dbo].[tblEpisode]
pivot(count([EpisodeId]) for year([EpisodeDate])   in ( [2005]
,[2006]
,[2007]
,[2008]
,[2009]
,[2010] )) as pivottable


select count([EpisodeId]), [SeriesNumber],year([EpisodeDate]) episodeyear from [dbo].[tblEpisode]
group by [SeriesNumber],year([EpisodeDate])

select 
* from episodeyear where RowNumber <= 73


WITH cte AS 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY title ORDER BY title)'RowRank'
FROM tblEpisode
)

SELECT title,[EpisodeId],DENSE_RANK() OVER( ORDER BY [EpisodeId] DESC) ranks
FROM tblEpisode

create table empl(email varchar(50), name varchar(10))

insert into empl values('don@aaa.com','don'),
('sam@aaa.com','SAM'),
('bob@bbb.com','bob'),
('dod@ccc.com','dod')

select substring(email,charindex('@',email)+1, len(email)-charindex('@',email))from empl

select (substring(email,charindex('@',email)+1, len(email)-charindex('@',email))) domain  , count(*) as 'total'
from empl group by substring(email,charindex('@',email)+1, len(email)-charindex('@',email)) 

create proc spListDelegates ( @orgname varchar(100), @coursename varchar(100), @firstname varchar(50)
)
as begin

SELECT tblOrg.OrgName, tblCourse.CourseName, tblPerson.FirstName
FROM   tblPerson INNER JOIN
             tblDelegate ON tblPerson.Personid = tblDelegate.PersonId INNER JOIN
             tblOrg ON tblPerson.OrgId = tblOrg.OrgId INNER JOIN
             tblSchedule ON tblDelegate.ScheduleId = tblSchedule.ScheduleId INNER JOIN
             tblCourse ON tblSchedule.CourseId = tblCourse.CourseId
where OrgName = @orgname and CourseName= @coursename and FirstName= @firstname

--tomorrow weekname
SELECT DATENAME(dw, DATEADD(dd,DATEPART(dd,GETDATE()) + 1, GETDATE()))

--add date 
SELECT DATEADD(ww, 7, current_timestamp);
SELECT DATEADD(ww, 1, current_timestamp);

SELECT DATEpart(day, '20031231');
--first month of year
SELECT datename(mm,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) )
--first date of month
SELECT DATEADD(yy, DATEDIFF(yy, 0, getdate()), 0)

select DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) 

select 
DATEPART(dd,GETDATE())

alter table tablename 
add constraint  fk_name foreign key (columnmae) refrences othertablename (columnname);