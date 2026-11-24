-- Esquema HR para los ejercicios de SQL de Bases de Datos 1.
-- Ejecutar primero, con F5 (Run Script) en Oracle SQL Developer, sobre un esquema vacio.

CREATE TABLE regions
    (
     region_id   NUMBER        NOT NULL ,
     region_name VARCHAR2 (25)
    )
;

ALTER TABLE regions
    ADD CONSTRAINT regions_pk PRIMARY KEY ( region_id ) ;

CREATE TABLE countries
    (
     country_id   CHAR (2)      NOT NULL ,
     country_name VARCHAR2 (40) ,
     region_id    NUMBER        NOT NULL
    )
;

ALTER TABLE countries
    ADD CONSTRAINT countries_pk PRIMARY KEY ( country_id ) ;

CREATE TABLE locations
    (
     location_id    NUMBER (4)    NOT NULL ,
     street_address VARCHAR2 (40) ,
     postal_code    VARCHAR2 (12) ,
     city           VARCHAR2 (30) NOT NULL ,
     state_province VARCHAR2 (25) ,
     country_id     CHAR (2)      NOT NULL
    )
;

ALTER TABLE locations
    ADD CONSTRAINT locations_pk PRIMARY KEY ( location_id ) ;

CREATE TABLE departments
    (
     department_id   NUMBER (4)    NOT NULL ,
     department_name VARCHAR2 (30) NOT NULL ,
     manager_id      NUMBER (6) ,
     location_id     NUMBER (4)
    )
;

ALTER TABLE departments
    ADD CONSTRAINT departments_pk PRIMARY KEY ( department_id ) ;

CREATE TABLE jobs
    (
     job_id     VARCHAR2 (10) NOT NULL ,
     job_title  VARCHAR2 (35) NOT NULL ,
     min_salary NUMBER (6) ,
     max_salary NUMBER (6)
    )
;

ALTER TABLE jobs
    ADD CONSTRAINT jobs_pk PRIMARY KEY ( job_id ) ;

ALTER TABLE jobs
    ADD CONSTRAINT jobs_salary_ck CHECK ( min_salary <= max_salary ) ;

CREATE TABLE employees
    (
     employee_id    NUMBER (6)    NOT NULL ,
     first_name     VARCHAR2 (20) ,
     last_name      VARCHAR2 (25) NOT NULL ,
     email          VARCHAR2 (25) NOT NULL ,
     phone_number   VARCHAR2 (20) ,
     hire_date      DATE          NOT NULL ,
     job_id         VARCHAR2 (10) NOT NULL ,
     salary         NUMBER (8,2) ,
     commission_pct NUMBER (2,2) ,
     manager_id     NUMBER (6) ,
     department_id  NUMBER (4)
    )
;

ALTER TABLE employees
    ADD CONSTRAINT employees_pk PRIMARY KEY ( employee_id ) ;

ALTER TABLE employees
    ADD CONSTRAINT employees_email_uk UNIQUE ( email ) ;

ALTER TABLE employees
    ADD CONSTRAINT employees_salary_ck CHECK ( salary > 0 ) ;

CREATE TABLE job_history
    (
     employee_id   NUMBER (6)    NOT NULL ,
     start_date    DATE          NOT NULL ,
     end_date      DATE          NOT NULL ,
     job_id        VARCHAR2 (10) NOT NULL ,
     department_id NUMBER (4)
    )
;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_pk PRIMARY KEY ( employee_id, start_date ) ;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_date_ck CHECK ( end_date > start_date ) ;

CREATE TABLE job_grades
    (
     grade_level VARCHAR2 (3) NOT NULL ,
     lowest_sal  NUMBER ,
     highest_sal NUMBER
    )
;

ALTER TABLE job_grades
    ADD CONSTRAINT job_grades_pk PRIMARY KEY ( grade_level ) ;

-- Llaves foraneas: conectan las tablas segun el modelo relacional de HR.

ALTER TABLE countries
    ADD CONSTRAINT countries_regions_fk FOREIGN KEY ( region_id )
    REFERENCES regions ( region_id ) ;

ALTER TABLE locations
    ADD CONSTRAINT locations_countries_fk FOREIGN KEY ( country_id )
    REFERENCES countries ( country_id ) ;

ALTER TABLE departments
    ADD CONSTRAINT departments_locations_fk FOREIGN KEY ( location_id )
    REFERENCES locations ( location_id ) ;

ALTER TABLE departments
    ADD CONSTRAINT departments_manager_fk FOREIGN KEY ( manager_id )
    REFERENCES employees ( employee_id ) ;

ALTER TABLE employees
    ADD CONSTRAINT employees_jobs_fk FOREIGN KEY ( job_id )
    REFERENCES jobs ( job_id ) ;

ALTER TABLE employees
    ADD CONSTRAINT employees_departments_fk FOREIGN KEY ( department_id )
    REFERENCES departments ( department_id ) ;

ALTER TABLE employees
    ADD CONSTRAINT employees_manager_fk FOREIGN KEY ( manager_id )
    REFERENCES employees ( employee_id ) ;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_employees_fk FOREIGN KEY ( employee_id )
    REFERENCES employees ( employee_id ) ;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_jobs_fk FOREIGN KEY ( job_id )
    REFERENCES jobs ( job_id ) ;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_departments_fk FOREIGN KEY ( department_id )
    REFERENCES departments ( department_id ) ;
