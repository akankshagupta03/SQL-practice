CREATE PROCEDURE dbo.NewTerms_Insert
    @ListID nvarchar(50) ,
    @TimeCreated datetime ,
    @TimeModified datetime 

AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO dbo.NewTerms
        (
            ListID  ,
            TimeCreated  ,
            TimeModified  

        )
    VALUES
        (
            @ListID  ,
            @TimeCreated  ,
            @TimeModified  

        )
END;
GO
exec newterms_insert 1, '2018-10-01' , '2018-10-02'
select * from newterms;
create table newterms (listid int,timecreated date, timemodified date);

create procedure dbo.dropcolumn
@columnid varchar(100)
as
begin
alter table newterms drop column @columnid
end
;
declare @myname varchar(10),
@mylastname varchar(10),
@mymiddlename varchar(10)
set @myname='Akanksha'
set @mylastname='Gupta'

select @myname+ ' '+@mymiddlename+' '+@mylastname
select concat (@myname, ' ',+@mymiddlename,@mylastname)
;
select @myname+ case when @mymiddlename is null then '' else ' '+ @mymiddlename end + ' ' + @mylastname
;

declare @mytime datetime='2018-09-03 10:00:00'
select 'the date and time is '+ convert(varchar(100),@mytime);
;
select * from [HumanResources].[Employee]
;
CREATE TABLE tblEmployee
(
EmployeeNumber INT NOT NULL,
EmployeeFirstName VARCHAR(50) NOT NULL,
EmployeeMiddleName VARCHAR(50) NULL,
EmployeeLastName VARCHAR(50) NOT NULL,
EmployeeGovernmentID CHAR(10) NULL,
DateOfBirth DATE NOT NULL
)

ALTER TABLE tblEmployee
ADD Department VARCHAR(10);

SELECT * FROM tblEmployee;

INSERT INTO tblEmployee
VALUES (132, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations');

ALTER TABLE tblEmployee
DROP COLUMN Department

ALTER TABLE tblEmployee
ADD Department VARCHAR(15)

ALTER TABLE tblEmployee
Add Department VARCHAR(20)

ALTER TABLE tblEmployee
ALTER COLUMN Department VARCHAR(19)

SELECT LEN( 'Customer Relations')

INSERT INTO tblEmployee([EmployeeFirstName],[EmployeeMiddleName],
[EmployeeLastName],[EmployeeGovernmentID],[DateOfBirth],[Department],[EmployeeNumber])
VALUES ('Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation',131);

INSERT INTO tblEmployee
VALUES (1, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(2,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation');

select
COUNT(EmployeeMiddleName) as NumberOfMiddleNames,
count(*)-count(EmployeeMiddleName) as NoMiddleName,
format(min(DateOfBirth),'dd-MM-yy') as EarliestDateOfBirth,
format(max(DateOfBirth),'D') as LatestDateOfBirth
FROM tblEmployee where EmployeeMiddleName like '[%a-z%]'
GROUP BY DATENAME(MONTH,DateOfBirth), DATEPART(MONTH,DateOfBirth)
ORDER BY DATEPART(MONTH,DateOfBirth)


select EmployeeMiddleName from tblEmployee where EmployeeMiddleName like '[%a-z%]'
create table
tblTransaction		
(Amount	smallmoney,	
DateOfTransaction	smalldatetime	,
[EmployeeNumber]	[int]	not null);

truncate table tbltransaction

select distinct department, '' as departmenthead
into tbldepartment
from tblEmployee

select * from (
select a.EmployeeFirstName, a.EmployeeLastName from tblEmployee a
order by a.EmployeeNumber)

alter table tblemployee
add constraint aadduu unique([EmployeeGovernmentID])

select [EmployeeGovernmentID], count([EmployeeGovernmentID])
from tblEmployee
group by [EmployeeGovernmentID]
having count([EmployeeGovernmentID])>1

create table tblemployee3 (
empid int constraint pk123 primary key identity(1,1),
empname varchar(10))

insert into tblemployee3
values ('A'),('B')

select * from tblemployee3

select @@IDENTITY
select SCOPE_IDENTITY()

select IDENT_CURRENT('tblemployee3')

set nocount off
select * from tbldepartment

alter tab
select * from sys.views



alter TRIGGER Tri_tbltransaction
    ON [dbo].[Tbltransaction]
    After DELETE, INSERT, UPDATE
    AS
    BEGIN
   select *,'inserted' from inserted
   select *,'deleted' from deleted
    END
	drop trigger tri_tbltransaction
	insert into tbltransaction values(113,'2018-02-08',123)

	select * from tbltransaction where amount =223


	SELECT  
  
TABLE_NAME FROM INFORMATION_SCHEMA.TABLES  
  
where  
  
Table_NAME NOT IN  
  
(  
  
SELECT DISTINCT c.TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS c  
  
INNER  
  
JOIN sys.identity_columns ic  
  
on  
  
(c.COLUMN_NAME=ic.NAME))  
  
AND  
  
TABLE_TYPE ='BASE TABLE'  

CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139

 create trigger tri_viewdept
 on [ViewByDepartment]
 instead of delete
 as
 begin
     declare @EmployeeNumber as int
	declare @DateOfTransaction as smalldatetime
	declare @Amount as smallmoney
select @EmployeeNumber = EmployeeNumber, @DateOfTransaction = DateOfTransaction,  @Amount = TotalAmount
	from deleted
	--SELECT * FROM deleted
	delete tblTransaction
	from tblTransaction as T
	where T.EmployeeNumber = @EmployeeNumber
	and T.DateOfTransaction = @DateOfTransaction
	and T.Amount = @Amount
END

select * from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
create table tbltransactionnew as
select * into tbltransactionnew from tbltransaction where 1=2

if object_id('myemployee','P') is not null
drop procedure myemployee
go
create procedure myemployee
(@empnofrom int, @empnoto int)
as
begin
if exists(select * from tblemployee where EmployeeNumber between @empnofrom and @empnoto)
begin
select EmployeeNumber,employeefirstname, employeelastname, dateofbirth from tblemployee
where EmployeeNumber between @empnofrom and @empnoto
end
end
go



exec myemployee 332,334



