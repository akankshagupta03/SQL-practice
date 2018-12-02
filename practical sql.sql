CREATE TABLE employees (
    emp_id integer NOT NULL,
    emp_name character varying(15),
    job_name character varying(10),
    manager_id integer,
    hire_date date,
    salary numeric(10,2),
    commission numeric(7,2),
    dep_id integer
);
CREATE TABLE department (
    dep_id integer NOT NULL,
    dep_name character varying(20),
    dep_location character varying(15)
);

CREATE TABLE job_grades (
    grade integer,
    min_sal integer,
    max_sal integer
);

CREATE TABLE bonus (
    emp_name character varying(15),
    job_name character varying(10),
    salary integer,
    commission integer
);
select * from department
insert into department(dep_id, dep_name, dep_location) values
(100,'FINANCE','SYDNEY')
insert into department(dep_id, dep_name, dep_location) values
(200,'AUDIT','MELBOURNE');
insert into department(dep_id, dep_name, dep_location) values
(300,'MARKETING','PERTH');
insert into department(dep_id, dep_name, dep_location) values
(400,'PRODUCTION','BRISBANE');

CREATE TABLE soccer_city (
    city_id numeric NOT NULL,
    city character varying(25) NOT NULL,
    country_id numeric NOT NULL
);

CREATE TABLE departments (
    department_id numeric(4,0) NOT NULL,
    department_name character varying(30) NOT NULL,
    manager_id numeric(6,0) DEFAULT NULL,
    location_id numeric(4,0) DEFAULT NULL
);
select * from job_grades

CREATE TABLE job_grades (
    grade_level character varying(20) NOT NULL,
    lowest_sal numeric(5,0) NOT NULL,
    highest_sal numeric(5,0) NOT NULL
);





insert into job_grades 
(grade_level, lowest_sal, highest_sal) values
('A',1000,2999);
insert into job_grades 
(grade_level, lowest_sal, highest_sal) values('B',3000,5999);
insert into job_grades 
(grade_level, lowest_sal, highest_sal) values('C',6000,9999);
insert into job_grades 
(grade_level, lowest_sal, highest_sal) values('D',10000,14999);
insert into job_grades 
(grade_level, lowest_sal, highest_sal) values('E',15000,24999);
insert into job_grades 
(grade_level, lowest_sal, highest_sal) values('F',25000,40000)

CREATE TABLE employees (
    employee_id numeric(6,0) DEFAULT (0) NOT NULL,
    first_name character varying(20) DEFAULT NULL,
    last_name character varying(25) NOT NULL,
    email character varying(25) NOT NULL,
    phone_number character varying(20) DEFAULT NULL,
    hire_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    salary numeric(8,2) DEFAULT NULL,
    commission_pct numeric(2,2) DEFAULT NULL,
    manager_id numeric(6,0) DEFAULT NULL,
    department_id numeric(4,0) DEFAULT NULL
);

CREATE TABLE locations (
    location_id numeric(4,0) DEFAULT (0) NOT NULL,
    street_address character varying(40) DEFAULT NULL,
    postal_code character varying(12) DEFAULT NULL,
    city character varying(30) NOT NULL,
    state_province character varying(25) DEFAULT NULL,
    country_id character varying(2) DEFAULT NULL
);
drop table employees



CREATE TABLE job_history (
    employee_id numeric(6,0) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    department_id numeric(4,0) DEFAULT NULL)
	insert into job_history (employee_id, start_date, end_date, job_id, department_id) values
	(201,'2004-02-17','2007-12-19','MK_REP',20);

	SELECT DATENAME(dw, DATEADD(dd, -DATEPART(dd, GETDATE()) + 1, GETDATE())) AS FirstDay