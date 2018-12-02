USE AdventureWorks2014
GO
drop procedure uspgetweek
alter PROCEDURE uspGetweek @salesvalue nvarchar(30)=null
AS

SELECT *
FROM table_A
WHERE salesvalue like '%'+ISNULL(@salesvalue,salesvalue)
--= ISNULL(@salesvalue,salesvalue)

GO
exec uspGetweek  @salesvalue='0'

select * from job_grades
select top 1 lowest_sal from (
select distinct top 4 lowest_sal from job_grades order by lowest_sal desc) a
 order by lowest_sal asc;

 select min(lowest_sal) from job_grades where lowest_sal in(
select distinct top 4 lowest_sal from job_grades order by lowest_sal desc) a
 order by lowest_sal asc;

 Create function ss(@y_year int)   
returns table   
as   
return select * from table_b where y_year = @y_year;
   exec sp_lock
exec ss 1
select * from ss(1991)

exec sp_helptext uspgetweek
select * from sys.sql_modules

Select * from table_A Select count(*) from table_B Select rows from sysindexes where id=OBJECT_ID(tablename) and indid<2

create trigger deep  
on emp  
for  
insert,update,delete  
as  
print'you can not insert,update and delete this table i'  
rollback;

create trigger insertt  
on emp  
after insert  
as  
begin  
insert into empstatus values('active')  
end   
update table_A set y_year =1991
select * from table_A
intersect
select * from table_b

select left(1991,2) from table_b

CREATE PROCEDURE uspGetweek @salesvalue nvarchar(30)=null
AS

SELECT *
FROM table_A
WHERE salesvalue like '%'+ISNULL(@salesvalue,salesvalue)
--= ISNULL(@salesvalue,salesvalue)


alter procedure uspgetweek
@salesvalue nvarchar(30)=null,
@weeknumber nvarchar(10) out
as

begin
select @weeknumber=count(weeknumber)
from table_A where salesvalue like '%'+ISNULL(@salesvalue,salesvalue);
end; 

declare variable_name variable_data_type.
declare @output int
execute uspgetweek 1,@output out
select output

CREATE PROC spOutputByweek  
@Id INT,  
@Name NVARCHAR(50) OUTPUT,  
@Gender NVARCHAR(10) OUTPUT  
AS  
BEGIN  
SELECT @Name = Name, @Gender = Gender  
from tblEmployees WHERE EmployeeId = @Id  
END  
  
  
CREATE PROC spReturnById  
@Id INT  
AS  
BEGIN  
RETURN (SELECT Name, Gender from tblEmployees WHERE EmployeeId = @Id)  
END  

create procedure uspgetdata
@weeknumber=null
as
begin
select * from table_A where 
end

create table item(itemId int,itemName varchar(15),itemCost int

insert into item

select 1,'a',100union all

select 2,'b',200union all

select 3,'c',300union all

select 4,'d',150


exec @@spid

select * from table_A where WeekNumber 

CREATE PROCEDURE STUDENT_MARKS
(IN STUDENT_REG_NO CHAR(15),IN TOTAL_MARKS DECIMAL(7,2), NO_SUBJECTS INT(3))
 LANGUAGE SQL MODIFIES SQL DATA 
 UPDATE STUDENTMAST.MARKS
 SET PERCENTAGE = TOTAL_MARKS/NO_SUBJECT
 WHERE REG_NO = STUDENT_REG_NO

 exec sp_columns table_a
 SELECT CONVERT(VARCHAR(11),GETDATE(), 10) 
 begin tran
 update table_a set y_year=1898
 rollback
 USE [AdventureWorks2014]
GO

DECLARE	@return_value int,
		@weeknumber nvarchar(10)

EXEC	@return_value = [dbo].[uspGetweek]
		@weeknumber = @weeknumber OUTPUT

SELECT	@weeknumber as N'@weeknumber'

SELECT	'Return Value' = @return_value

GO
CREATE TABLE Employee_Test
(
Emp_ID INT Identity,
Emp_name Varchar(100),
Emp_Sal Decimal (10,2)
)

INSERT INTO Employee_Test VALUES ('Anees',1000);
INSERT INTO Employee_Test VALUES ('Rick',1200);
INSERT INTO Employee_Test VALUES ('John',1100);
INSERT INTO Employee_Test VALUES ('Stephen',1300);
INSERT INTO Employee_Test VALUES ('Maria',1400);

CREATE TABLE Employee_Test_Audit
(
Emp_ID int,
Emp_name varchar(100),
Emp_Sal decimal (10,2),
Audit_Action varchar(100),
Audit_Timestamp datetime
)

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [mycolumn]
  FROM [AdventureWorks2014].[dbo].[tblfirst]

  create table employee (employeeid int,employeename int)

  declare @myvar int
  set @myvar=2
  select @myvar as myvariable

   declare @myvar float(24)=1234567.76544
  
  select @myvar as myvariable
  select * from [Production].[TransactionHistory]
  where mod([TransactionDate],2)=0


  select *
[HumanResources].[EmployeePayHistory]
-----nth highest salary
select top 1  rate from ( select distinct top 5 rate from [HumanResources].[EmployeePayHistory]
order by rate desc) as s order by rate

with result as(
select  rate, dense_rank() over (order by rate desc) as denserank from [HumanResources].[EmployeePayHistory])
select top 1 result.rate from result where result.denserank=5


