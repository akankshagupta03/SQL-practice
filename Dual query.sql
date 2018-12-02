SELECT TRUNC(SYSDATE, 'DAY') "First day of current month" FROM DUAL;

--1.Get the first day of the month
   SELECT TRUNC(SYSDATE, 'MONTH') "First day of current month" FROM DUAL;
--2.Get the last day of the month
   SELECT TRUNC(LAST_DAY(SYSDATE)) "Last day of current month" FROM DUAL;
--3.Get the first day of the Year
  SELECT TRUNC(SYSDATE, 'YEAR') "Year First Day" FROM DUAL;
--4.Get the last day of the year
  SELECT ADD_MONTHS(TRUNC(SYSDATE, 'YEAR'), 12) - 1 "Year Last Day"
  FROM DUAL
--5.Get number of days in current month
         SELECT CAST(TO_CHAR(LAST_DAY(SYSDATE), 'dd') AS VARCHAR2) number_of_days
           FROM DUAL; 

--6.Get number of days left in current month
  SELECT SYSDATE,
       LAST_DAY(SYSDATE) "Last",
       LAST_DAY(SYSDATE) - SYSDATE "Days left"
  FROM DUAL;
--7.Get number of days between two dates
  SELECT ROUND((MONTHS_BETWEEN('01-Feb-2014', '01-Mar-2012') * 30), 0) num_of_days
  FROM DUAL;
  OR
  SELECT TRUNC(sysdate) - TRUNC(e.hire_date) FROM employees;
--8.Display each months start and end date upto last month of the year
  SELECT ADD_MONTHS(TRUNC(SYSDATE, 'MONTH'), i) start_date,
       TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, i))) end_date
  FROM XMLTABLE('for $i in 0 to xs:int(D) return $i' PASSING
                XMLELEMENT(d,
                           FLOOR(MONTHS_BETWEEN(ADD_MONTHS(TRUNC(SYSDATE,
                                                                 'YEAR') - 1,
                                                           12),
                                                SYSDATE))) COLUMNS i
                INTEGER PATH '.');
--9.Get number of seconds passed since today (since 00:00 hr)
  SELECT (SYSDATE - TRUNC(SYSDATE)) * 24 * 60 * 60 num_of_sec_since_morning
  FROM DUAL;
--10.Get number of seconds left today (till 23:59:59 hr)
  SELECT (TRUNC(SYSDATE + 1) - SYSDATE) * 24 * 60 * 60 num_of_sec_left
  FROM DUAL;
--11.Check if a table exists in the current database schema
  SELECT table_name FROM user_tables WHERE table_name = 'TABLE_NAME';
--12.Check if a column exists in a table
  SELECT column_name AS FOUND
  FROM user_tab_cols
  WHERE table_name = 'TABLE_NAME'
   AND column_name = 'COLUMN_NAME';
--13.Showing the table structure
  SELECT DBMS_METADATA.get_ddl('TABLE', 'TABLE_NAME', 'USER_NAME') FROM DUAL;
--14.Getting current schema
  SELECT SYS_CONTEXT('userenv', 'current_schema') FROM DUAL;
  (or) SELECT user FROM DUAL;
--15.Changing current schema
  ALTER SESSION SET CURRENT_SCHEMA = new_schema;
--16.Database version information
SELECT * FROM v$version;
--17.Database default information
SELECT username, profile, default_tablespace, temporary_tablespace
  FROM dba_users;
--18.Database Character Set information
SELECT * FROM nls_database_parameters;
--19.Get Oracle version
SELECT VALUE FROM v$system_parameter WHERE name = 'compatible';
--20.Store data case sensitive but to index it case insensitive
CREATE TABLE tab(col1 VARCHAR2(10));
CREATE INDEX idx1 ON tab(UPPER(col1));
ANALYZE TABLE a COMPUTE STATISTICS;
--21.Resizing Tablespace without adding datafile
ALTER DATABASE DATAFILE '/work/oradata/STARTST/STAR02D.dbf' resize 2000M;
--22.Checking autoextend on/off for Tablespaces
SELECT SUBSTR(file_name, 1, 50), AUTOEXTENSIBLE FROM dba_data_files;
(OR)
  SELECT tablespace_name, AUTOEXTENSIBLE FROM dba_data_files;
--23.Adding datafile to a tablespace
ALTER TABLESPACE data01 ADD DATAFILE '/work/oradata/STARTST/data01.dbf' SIZE 1000M AUTOEXTEND OFF;
--24.Increasing datafile size
ALTER DATABASE DATAFILE '/u01/app/Test_data_01.dbf' RESIZE 2G;
--25.Find the Actual size of a Database
SELECT SUM(bytes) / 1024 / 1024 / 1024 AS GB FROM dba_data_files;
--26.Find the size occupied by Data in a Database or Database usage details
SELECT SUM(bytes) / 1024 / 1024 / 1024 AS GB FROM dba_segments;
--27.Find the size of the SCHEMA/USER
SELECT SUM(bytes / 1024 / 1024) "size"
  FROM dba_segments
 WHERE owner = '&owner';
--28.Last SQL fired by the User on Database
SELECT S.USERNAME || '(' || s.sid || ')-' || s.osuser UNAME,
       s.program || '-' || s.terminal || '(' || s.machine || ')' PROG,
       s.sid || '/' || s.serial# sid,
       s.status "Status",
       p.spid,
       sql_text sqltext
  FROM v$sqltext_with_newlines t, V$SESSION s, v$process p
 WHERE t.address = s.sql_address
   AND p.addr = s.paddr(+)
   AND t.hash_value = s.sql_hash_value
 ORDER BY s.sid, t.piece;
--29.CPU usage of the USER
SELECT ss.username, se.SID, VALUE / 100 cpu_usage_seconds
  FROM v$session ss, v$sesstat se, v$statname sn
 WHERE se.STATISTIC# = sn.STATISTIC#
   AND NAME LIKE '%CPU used by this session%'
   AND se.SID = ss.SID
   AND ss.status = 'ACTIVE'
   AND ss.username IS NOT NULLORDER BY VALUE DESC;
--30.Long Query progress in database
SELECT a.sid,
       a.serial#,
       b.username,
       opname OPERATION,
       target OBJECT,
       TRUNC(elapsed_seconds, 5) "ET (s)",
       TO_CHAR(start_time, 'HH24:MI:SS') start_time,
       ROUND((sofar / totalwork) * 100, 2) "COMPLETE (%)"
  FROM v$session_longops a, v$session b
 WHERE a.sid = b.sid
   AND b.username NOT IN ('SYS', 'SYSTEM')
   AND totalwork > 0
 ORDER BY elapsed_seconds;
--31.Get current session id, process id, client process id?
SELECT b.sid, b.serial#, a.spid processid, b.process clientpid
  FROM v$process a, v$session b
 WHERE a.addr = b.paddr
   AND b.audsid = USERENV('sessionid');

--32.Last SQL Fired from particular Schema or Table:
  SELECT CREATED, TIMESTAMP, last_ddl_time
    FROM all_objects
   WHERE OWNER = 'MYSCHEMA'
     AND OBJECT_TYPE = 'TABLE'
     AND OBJECT_NAME = 'EMPLOYEE_TABLE';
--33.Find Top 10 SQL by reads per execution
SELECT *
  FROM (SELECT ROWNUM,
               SUBSTR(a.sql_text, 1, 200) sql_text,
               TRUNC(a.disk_reads / DECODE(a.executions, 0, 1, a.executions)) reads_per_execution,
               a.buffer_gets,
               a.disk_reads,
               a.executions,
               a.sorts,
               a.address
          FROM v$sqlarea a
         ORDER BY 3 DESC)
 WHERE ROWNUM < 10;
--34.Oracle SQL query over the view that shows actual Oracle connections.
SELECT osuser, username, machine, program FROM v$session ORDER BY osuser;
--35.Oracle SQL query that show the opened connections group by the program that opens the connection.
SELECT program application, COUNT(program) Numero_Sesiones
  FROM v$session
 GROUP BY program
 ORDER BY Numero_Sesiones DESC;
--36.Oracle SQL query that shows Oracle users connected and the sessions number for user
SELECT username Usuario_Oracle, COUNT(username) Numero_Sesiones
  FROM v$session
 GROUP BY username
 ORDER BY Numero_Sesiones DESC;
--37.Get number of objects per owner
SELECT owner, COUNT(owner) number_of_objects
  FROM dba_objects
 GROUP BY owner
 ORDER BY number_of_objects DESC;
--38.Convert number to words
SELECT TO_CHAR(TO_DATE(1526, 'j'), 'jsp') FROM DUAL;
Output :one thousand five hundred twenty - six
--39.Find string in package source code
  SELECT *
    FROM dba_source
   WHERE UPPER(text) LIKE '%FOO_SOMETHING%'
     AND owner = 'USER_NAME';
--40.Convert Comma Separated Values into Table
WITH csv AS
 (SELECT 'AA,BB,CC,DD,EE,FF' AS csvdata FROM DUAL)
SELECT REGEXP_SUBSTR(csv.csvdata, '[^,]+', 1, LEVEL) pivot_char
  FROM DUAL, csv
CONNECT BY REGEXP_SUBSTR(csv.csvdata, '[^,]+', 1, LEVEL) IS NOT NULL;

--41.Find the last record from a table

SELECT * FROM employees WHERE ROWID IN (SELECT MAX(ROWID) FROM employees);
(OR)
  SELECT *
    FROM employees
  MINUS
  SELECT *
    FROM employees
   WHERE ROWNUM < (SELECT COUNT(*) FROM employees);
--42.Row Data Multiplication in Oracle
WITH tbl AS
 (SELECT -2 num
    FROM DUAL
  UNION
  SELECT -3 num
    FROM DUAL
  UNION
  SELECT -4 num
    FROM DUAL),
sign_val AS
 (SELECT CASE MOD(COUNT(*), 2)
           WHEN 0 THEN
            1
           ELSE
            -1
         END val
    FROM tbl
   WHERE num < 0)
SELECT EXP(SUM(LN(ABS(num)))) * val FROM tbl, sign_val GROUP BY val;
--43.Generating Random Data In Oracle
SELECT LEVEL empl_id,
       MOD(ROWNUM, 50000) dept_id,
       TRUNC(DBMS_RANDOM.VALUE(1000, 500000), 2) salary,
       DECODE(ROUND(DBMS_RANDOM.VALUE(1, 2)), 1, 'M', 2, 'F') gender,
       TO_DATE(ROUND(DBMS_RANDOM.VALUE(1, 28)) || '-' ||
               ROUND(DBMS_RANDOM.VALUE(1, 12)) || '-' ||
               ROUND(DBMS_RANDOM.VALUE(1900, 2010)),
               'DD-MM-YYYY') dob,
       DBMS_RANDOM.STRING('x', DBMS_RANDOM.VALUE(20, 50)) address
  FROM DUAL
CONNECT BY LEVEL < 10000;

--44.Random number generator in Oracle
SELECT ROUND(DBMS_RANDOM.VALUE() * 100) + 1 AS random_num FROM DUAL;
--45.Check if table contains any data
SELECT 1 FROM TABLE_NAME WHERE ROWNUM = 1;
