REM ******************************************************************
REM  File:        sql_book_add_tables.sql
REM  Description: Script to create additional example tables found in the
REM               Oracle SQL by Example.
REM               To drop the tables created in this script, run 
REM               drop_extra_tables.sql
REM  Created:     May 3, 2002 AR
REM  Revised:     June 21, 2004 AR
REM  Revised:     Febr 02, 2009 AR
REM  Revised:     April 04, 2009 AR
REM  Version:     4.0
REM ******************************************************************


SET ECHO OFF

PROMPT Chapter 4: Character, Number, and Miscellaneous Functions
PROMPT Lab 4.3
CREATE TABLE grade_summary
  (student_id NUMBER(8),
   midterm_grade NUMBER(3),
   finalexam_grade NUMBER(3),
   quiz_grade NUMBER(3)
   );

INSERT INTO grade_summary
VALUES (123, 90, 50, 100);
INSERT INTO grade_summary
VALUES (456, 80, 95, null);
INSERT INTO grade_summary
VALUES (678, null, null, 98);
INSERT INTO grade_summary
VALUES (789, null, 78, 85);
INSERT INTO grade_summary
VALUES (999, null, null, null);
COMMIT;


CREATE TABLE float_test
  (test_col BINARY_FLOAT);

INSERT INTO float_test (test_col) VALUES (2.5f);
INSERT INTO float_test (test_col) VALUES (BINARY_FLOAT_NAN);
COMMIT;



PROMPT Chapter 5: Date and Conversion Functions
PROMPT Lab 5.3
CREATE TABLE date_example
  (col_date DATE,
   col_timestamp TIMESTAMP(6), 
   col_timestamp_w_tz tIMESTAMP WITH TIME ZONE,
   col_timestamp_w_local_tz TIMESTAMP WITH LOCAL TIME ZONE
   );
INSERT INTO date_example
  (col_date, 
   col_timestamp, 
   col_timestamp_w_tz,
   col_timestamp_w_local_tz)
VALUES
  (TO_DATE('24-FEB-2009 16:25:32', 'DD-MON-YYYY HH24:MI:SS'),
   TO_TIMESTAMP('24-FEB-2009 16:25:32.0000000', 'DD-MON-YYYY  HH24:MI:SS.FF'),
   TO_TIMESTAMP_TZ('24-FEB-2009 16:25:32.0000000 -5:00', 'DD-MON-YYYY HH24:MI:SS.FF TZH:TZM'),
   TO_TIMESTAMP('24-FEB-2009 16:25:32.0000000', ' DD-MON-YYYY HH24:MI:SS.FF'));
COMMIT;

PROMPT Lab 5.4
CREATE TABLE meeting
(meeting_id NUMBER(10,0),
 meeting_start DATE,
 meeting_end DATE);

INSERT INTO meeting
VALUES (1, TO_DATE('01-JUL-2009 9:30AM', 'DD-MON-YYYY HH:MI PM'),
TO_DATE('01-JUL-2009 10:30AM', 'DD-MON-YYYY HH:MI PM'));
INSERT INTO meeting
VALUES (2, TO_DATE('01-JUL-2009 3:00PM', 'DD-MON-YYYY HH:MI PM'),
TO_DATE('01-JUL-2009 4:30PM', 'DD-MON-YYYY HH:MI PM'));
COMMIT;


PROMPT Lab 5.5
CREATE TABLE conversion_example
  (course_no VARCHAR2(9));
INSERT INTO conversion_example VALUES ('123');
INSERT INTO conversion_example VALUES ('xyz');
COMMIT;


PROMPT Chapter 9: Set Operations and Chapter 9: Complex Joins
PROMPT Lab 9.2
CREATE TABLE t1
  (col1 NUMBER);
CREATE TABLE t2
  (col2 NUMBER);

CREATE TABLE t3
  (col3 NUMBER);

INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
INSERT INTO t1 VALUES (3);

INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (3);
INSERT INTO t2 VALUES (4);

INSERT INTO t3 VALUES (2);
INSERT INTO t3 VALUES (3);
INSERT INTO t3 VALUES (5);

COMMIT;

PROMPT Chapter 11: Insert, Update, and Delete

CREATE TABLE intro_course
(course_no NUMBER(8),
 description_tx VARCHAR2(50),
 cost NUMBER(9,2),
 prereq_no NUMBER(8),
 created_by VARCHAR2(30),
 created_date DATE,
 modified_by VARCHAR2(30),
 modified_date DATE);

CREATE TABLE section_history 
( section_id      NUMBER(8),
  start_date_time DATE,
  course_no       NUMBER(8),
  section_no      NUMBER(3));
 
CREATE TABLE capacity_history
( section_id NUMBER(8),
  location   VARCHAR2(50),
  capacity   NUMBER(3)
);

CREATE TABLE grade_distribution
 (section_id NUMBER(8),
  grade_a    NUMBER(4,0),
  grade_b    NUMBER(4,0),
  grade_c    NUMBER(4,0),
  grade_d    NUMBER(4,0),
  grade_f    NUMBER(4,0));
INSERT INTO grade_distribution
VALUES (400, 5, 10,3, 0, 0);
INSERT INTO grade_distribution
VALUES (401, 1, 3,5, 1, 0);
INSERT INTO grade_distribution
VALUES (402, 5, 10,3, 0, 1);
COMMIT;
 
CREATE TABLE grade_distribution_normalized
(section_id NUMBER(8),
 letter_grade VARCHAR2(2),
 num_of_students NUMBER(4,0));
 
CREATE TABLE ta
 (ID NUMBER,
  col1 VARCHAR2(4));
  
CREATE TABLE tb
 (ID NUMBER,
  col2 VARCHAR2(4));
  
INSERT INTO ta
VALUES (1, 'a');
INSERT INTO ta
VALUES (2, 'b');
INSERT INTO ta
VALUES (3, 'c');
INSERT INTO ta
VALUES (4, 'd');

INSERT INTO tb
VALUES (1, 'w');
INSERT INTO tb
VALUES (2, 'x');
INSERT INTO tb
VALUES (5, 'y');
INSERT INTO tb
VALUES (6, 'z');
COMMIT;


CREATE TABLE employee
 (employee_id NUMBER,
  name VARCHAR2(10),
  salary NUMBER,
  title VARCHAR2(10));

CREATE TABLE employee_change
 (employee_id NUMBER,
  name VARCHAR2(10),
  salary NUMBER,
  title VARCHAR2(10));
  
INSERT INTO employee
VALUES (1, 'John', 1000, 'Analyst');
INSERT INTO employee
VALUES (2, 'Mary', 2000, 'Manager');
INSERT INTO employee
VALUES (3, 'Stella', 5000, 'President');
INSERT INTO employee
VALUES (4, 'Fred', 500, 'Janitor');

INSERT INTO employee_change
(employee_id, name, title, salary)
VALUES (1, 'John','Programmer', 1500);
INSERT INTO employee_change
(employee_id, name, title, salary)
VALUES (3, 'Stella', 'CEO', 6000);
INSERT INTO employee_change
(employee_id, name, title, salary)
VALUES (4, 'Fred', 'Clerk', 600);
INSERT INTO employee_change
(employee_id, name, title, salary)
VALUES (5, 'Jean', 'Secretary', 800);
INSERT INTO employee_change
(employee_id, name, title, salary)
VALUES (6, 'Betsy', 'Sales Rep', 2000);
COMMIT;


PROMPT Chapter 16: Regular Expressions and Hierarchical Queries
PROMPT Lab 16.1
CREATE TABLE zipcode_example
( 
  zip             VARCHAR2(5));

COMMENT ON TABLE zipcode_example IS 'Regular Expression examples';

INSERT INTO zipcode_example
(zip)
VALUES
('ab123');
INSERT INTO zipcode_example
(zip)
VALUES
('123xy');
INSERT INTO zipcode_example
(zip)
VALUES
('007ab');
INSERT INTO zipcode_example
(zip)
VALUES
('abcxy');
INSERT INTO zipcode_example
(zip)
VALUES
('10025');
COMMIT;



PROMPT Chapter 17: Exploring Data Warehousing Features

PROMPT Lab 17.1
CREATE TABLE course_revenue
(
  course_no       NUMBER(8) NOT NULL,
  revenue         NUMBER,
  course_fee      NUMBER(9,2),
  num_enrolled    NUMBER,
  num_of_sections NUMBER);

COMMENT ON TABLE course_revenue IS 'Revenues of courses'
/

COMMENT ON COLUMN course_revenue.course_no IS 'The course_no of a course.'
/
COMMENT ON COLUMN course_revenue.revenue IS 'The revenue generated by the respective course_no.'
/
COMMENT ON COLUMN course_revenue.COURSE_fee IS 'The amount charged for enrollment in individual course.'
/
COMMENT ON COLUMN course_revenue.NUM_ENROLLED IS 'Stores the number of students enrolled in the course.'
/
COMMENT ON COLUMN course_revenue.NUM_of_sections IS 'Stores the number of section each course per course.'
/
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (10, 1195, 1195, 1, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (20, 10755, 1195, 9, 4);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (25, 53775, 1195, 45, 8);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (100, 15535, 1195, 13, 5);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (120, 27485, 1195, 23, 6);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (122, 28680, 1195, 24, 5);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (124, 9560, 1195, 8, 3);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (125, 9560, 1195, 8, 4);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (130, 9560, 1195, 8, 3);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (132, 2390, 1195, 2, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (134, 2390, 1195, 2, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (135, 4380, 1095, 4, 3);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (140, 17925, 1195, 15, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (142, 8365, 1195, 7, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (145, 2390, 1195, 2, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (146, 3585, 1195, 3, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (147, 5975, 1195, 5, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (204, 1195, 1195, 1, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (230, 15330, 1095, 14, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (240, 14235, 1095, 13, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (310, 4780, 1195, 4, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (330, 3585, 1195, 3, 1);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (350, 10755, 1195, 9, 2);
INSERT INTO course_revenue (course_no, revenue, course_fee, num_enrolled, num_of_sections)
VALUES (420, 2390, 1195, 2, 1);
COMMIT;

PROMPT Lab 17.2

CREATE TABLE instructor_summary
(
  instructor_id   NUMBER(8) NOT NULL,
  gender          CHAR(1),
  campus          VARCHAR2(11),
  semester_year   VARCHAR2(4) NOT NULL,
  semester_month  VARCHAR2(2) NOT NULL,
  num_of_classes  NUMBER,
  num_of_students NUMBER,
  revenue         NUMBER);

ALTER TABLE instructor_summary
  ADD CONSTRAINT instructor_summary_pk 
  PRIMARY KEY (instructor_id,semester_year,semester_month);

INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (101, 'M', 'LIBERTY', '2007', '06', 9, 45, 51380);
INSERT INTO instructor_summary (instructor_id, gender, campus, semester_year, semester_month, num_of_classes, num_of_students, revenue)
VALUES (102, 'M', 'MORNINGSIDE', '2007', '07', 10, 21, 28580);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (103, 'F', 'MORNINGSIDE', '2008', '07', 10, 37, 44215);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (104, 'M', null, '2007', '07', 10, 25, 29675);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (105, 'F', 'LIBERTY', '2007', '06', 10, 16, 23800);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (106, 'U', 'MORNINGSIDE', '2007', '07', 10, 18, 24995);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (107, 'U', 'DOWNTOWN', '2007', '07', 10, 31, 38135);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (108, 'M', 'MORNINGSIDE', '2007', '07', 9, 33, 41625);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (109, 'U', 'LIBERTY', '2007', '05', 0, 0, 0);
INSERT INTO INSTRUCTOR_SUMMARY (INSTRUCTOR_ID, GENDER, CAMPUS, SEMESTER_YEAR, SEMESTER_MONTH, NUM_OF_CLASSES, NUM_OF_STUDENTS, REVENUE)
VALUES (110, 'F', null, '2007', '05', 0, 0, 0);
COMMIT;



create table MODEL_EXAMPLE
(
  COURSE    VARCHAR2(30),
  GENDER    CHAR(1),
  YEAR      NUMBER,
  ENROLL_NO NUMBER);

insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('F', 2008, 37, 'Spanish I');
insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('M', 2008, 3, 'Spanish I');
insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('F', 2008, 59, 'Spanish II');
insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('M', 2008, 35, 'Spanish II');
insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('F', 2008, 3, 'Spanish III');
insert into MODEL_EXAMPLE (GENDER, YEAR, ENROLL_NO, COURSE)
values ('M', 2008, 34, 'Spanish III');
commit;

SET ECHO ON
