REM ******************************************************************
REM  File: dropStudent.sql
REM  Description: used for droping student schema objects. Note that
REM   this script only drops the objects created for the STUDENT 
REM   related tables not the supplemental tables.
REM  Created January 30, 2000
REM  Modified June 21, 2004 AR
REM  Modified May 2, 2009 AR
REM ******************************************************************

PROMPT Dropping Student schema objects

REM === Drop Tables ===

DROP TABLE COURSE CASCADE CONSTRAINTS;
DROP TABLE ENROLLMENT CASCADE CONSTRAINTS;
DROP TABLE GRADE CASCADE CONSTRAINTS;
DROP TABLE GRADE_CONVERSION CASCADE CONSTRAINTS;
DROP TABLE GRADE_TYPE CASCADE CONSTRAINTS;
DROP TABLE GRADE_TYPE_WEIGHT CASCADE CONSTRAINTS;
DROP TABLE INSTRUCTOR CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE ZIPCODE CASCADE CONSTRAINTS;

REM === Drop Sequences ===
DROP SEQUENCE COURSE_NO_SEQ;
DROP SEQUENCE INSTRUCTOR_ID_SEQ;
DROP SEQUENCE SECTION_ID_SEQ;
DROP SEQUENCE STUDENT_ID_SEQ;
