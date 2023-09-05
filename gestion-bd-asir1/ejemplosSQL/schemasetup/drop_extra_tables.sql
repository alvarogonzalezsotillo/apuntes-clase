REM ******************************************************************
REM  File:        drop_extra_tables.sql
REM  Description: Script to drop the tables created by the 
REM               sql_book_add_tables.sql script.
REM  Created:     December 22, 2002 AR
REM  MODIFIED:    June 21, 2004 AR
REM  Version:     2.0
REM ******************************************************************


SET ECHO OFF

PROMPT Dropping supplemental tables.

DROP TABLE CAPACITY_HISTORY;
DROP TABLE CONVERSION_EXAMPLE;
DROP TABLE COURSE_REVENUE;
DROP TABLE DATE_EXAMPLE;
DROP TABLE EMPLOYEE;
DROP TABLE EMPLOYEE_CHANGE;
DROP TABLE GRADE_DISTRIBUTION;
DROP TABLE GRADE_DISTRIBUTION_NORMALIZED;
DROP TABLE GRADE_SUMMARY;
DROP TABLE INSTRUCTOR_SUMMARY;
DROP TABLE INTRO_COURSE;
DROP TABLE MEETING;
DROP TABLE SECTION_HISTORY;
DROP TABLE T1;
DROP TABLE T2;
DROP TABLE T3;
DROP TABLE TA;
DROP TABLE TB;
DROP TABLE ZIPCODE_EXAMPLE;
DROP TABLE FLOAT_TEST;
DROP TABLE MODEL_EXAMPLE;


SET ECHO ON

