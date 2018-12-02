use AdventureWorks2014
go

set nocount on
-- Write a query to display the first day of the month (in datetime format) three months 
	select dateadd(DD,-2,dateadd(MONTH,-3,'2014-09-03'))


select dateadd(dd, 27,dateadd(MONTH,-3,getdate()))
--2. Write a query to display the last day of the month (in datetime format) three months before the current month
select eomonth(dateadd(MONTH,-3,'2014-10-03'))

--. Write a query to get the distinct Mondays from hire_date in employees tables.
select distinct HireDate
from
[HumanResources].[Employee] where datename(DW,hiredate)='Monday'


---first day of current year
select datename(dw,dateadd(DD,-1,dateadd(month,-11,getdate())))
--last day of current year
select datename(dw,EOMONTH(dateadd(month,-11,getdate())))

---Write a query to calculate the age in year
select datediff(year,'1989-10-03',getdate())

--Write a query to get the current date in the following format
--Sample date : 2014-09-04
--Output : September 4, 2014

select format(getdate(),'MM d,yyyy')
select convert(varchar, getdate(),107)

select datename(month,(getdate()))+ format(getdate(),' d, yyyy')

--query to get the current date in Thursday September 2014 format

select datename(dw,getdate())+' '+datename(month,(getdate()))+ format(getdate(),' d, yyyy')

--9. Write a query to extract the year from the current date
select year(getdate())

--10. Write a query to get the DATE value from a given day (number in N). 
--Sample days: 730677
--Output : 2000-07-11

select dateadd(day, 730677 - 693961, 0)

select dateadd(day,0,730677)

use northwind
go

--Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30
select firstname, HireDate from employees
where hiredate between '1987-06-01' and '2018-07-30'

--12. Write a query to display the current date in the following format.
--Sample output: Thursday 4th September 2014 00:00:00

select datename(dw,getdate()) +' '+datename(day,getdate()) +'nd '+datename(month,getdate()) + format(getdate(),' yyyy HH:MM:ss')

select CAST(DATEADD(YEAR, 1, CAST(GETDATE() AS DATE)) AS DATETIME) 

select format(cast(getdate() as datetime),'yyyy HH:MM:ss')

---13. Write a query to display the current date in the following format. Go to the editor
--Sample output: 05/09/2014

select format(getdate(), 'dd/MM/yyyy')

----14. Write a query to display the current date in the following format. Go to the editor
---Sample output: 12:00 AM Sep 5, 2014

SELECT CONVERT(varchar(15),  CAST(GETDATE() AS TIME), 100)+' '+ CONVERT(varchar(15),getdate(),107)

---15. Write a query to get the firstname, lastname who joined in the month of June.

select firstname,lastname, hiredate from [dbo].[Employees] where 
--year(hiredate)=1992
cast(month(hiredate)as varchar)='april'

