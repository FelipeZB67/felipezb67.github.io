---
title: SQL
description: Scripts de Oracle con la creación del esquema HR, sus datos de prueba y las consultas de cada presentación del curso.
category: Evidencias
importance: 3
---

## SQL

[Descargar scripts .sql (ZIP)](/assets/sql/scripts_sql_hr.zip)

Estos scripts corresponden al esquema HR (Recursos Humanos) que se usa en las presentaciones de SQL del curso: empleados, departamentos, cargos, sedes, países y regiones. Incluyen la creación de las tablas con sus restricciones (PK, FK, UNIQUE y CHECK), la inserción de datos de prueba propios y las consultas de cada tema, desde la presentación 2 hasta la 9.

Están escritos para Oracle Database y se ejecutan en orden desde Oracle SQL Developer. Los dos primeros archivos se corren completos con F5 (Run Script) y cada consulta se puede ejecutar sola con Ctrl+Enter.

**Objetivo de aprendizaje:** Crear un esquema relacional completo en Oracle y consultarlo con todo lo visto en las presentaciones: filtros, funciones de una fila, conversiones, funciones de grupo, JOIN, subconsultas y operadores de conjunto.

<div style="display:flex;flex-wrap:wrap;gap:0.75rem;margin:1.5rem 0;"><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">8</div><div style="font-size:0.75rem;letter-spacing:0.08em;">TABLAS</div></div><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">70</div><div style="font-size:0.75rem;letter-spacing:0.08em;">INSERCIONES</div></div><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">32</div><div style="font-size:0.75rem;letter-spacing:0.08em;">CONSULTAS</div></div><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">8</div><div style="font-size:0.75rem;letter-spacing:0.08em;">PRESENTACIONES</div></div></div>

### 1. DDL: Creación de tablas y restricciones

[01_creacion_objetos.sql](/assets/sql/01_creacion_objetos.sql) define las 8 tablas del esquema HR con sus llaves primarias, la restricción UNIQUE del correo, 3 restricciones CHECK y las llaves foráneas que las conectan.

#### Tablas, llaves primarias, UNIQUE y CHECK

```sql
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
```

#### Llaves foráneas

Se agregan al final, cuando todas las tablas ya existen. DEPARTMENTS y EMPLOYEES se apuntan entre sí: el departamento tiene un jefe y cada empleado tiene un departamento.

```sql
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
```

### 2. DML: Inserción de datos de prueba

[02_insercion_datos.sql](/assets/sql/02_insercion_datos.sql) carga 70 filas de prueba. Los departamentos se insertan sin jefe y se les asigna al final con UPDATE, porque el jefe es un empleado que todavía no existe cuando se crea el departamento.

```sql
-- Datos de prueba del esquema HR. Ejecutar despues de 01_creacion_objetos.sql con F5.
-- Los departamentos se insertan sin jefe y se les asigna al final, porque el jefe
-- es un empleado que todavia no existe cuando se crea el departamento.

-- Regiones
INSERT INTO regions VALUES (1, 'Europa');
INSERT INTO regions VALUES (2, 'America');
INSERT INTO regions VALUES (3, 'Asia');
INSERT INTO regions VALUES (4, 'Medio Oriente y Africa');

-- Paises
INSERT INTO countries VALUES ('CO', 'Colombia', 2);
INSERT INTO countries VALUES ('MX', 'Mexico', 2);
INSERT INTO countries VALUES ('US', 'Estados Unidos', 2);
INSERT INTO countries VALUES ('ES', 'Espana', 1);
INSERT INTO countries VALUES ('DE', 'Alemania', 1);
INSERT INTO countries VALUES ('JP', 'Japon', 3);

-- Sedes
INSERT INTO locations VALUES (1000, 'Calle 26 # 68 35', '111071', 'Bogota', 'Cundinamarca', 'CO');
INSERT INTO locations VALUES (1100, 'Carrera 43A # 1 50', '050021', 'Medellin', 'Antioquia', 'CO');
INSERT INTO locations VALUES (1200, 'Avenida Reforma 222', '06600', 'Ciudad de Mexico', NULL, 'MX');
INSERT INTO locations VALUES (1300, 'Calle de Alcala 45', '28014', 'Madrid', 'Madrid', 'ES');
INSERT INTO locations VALUES (1400, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO locations VALUES (1500, '2017 Shinjuku', '1689', 'Tokio', NULL, 'JP');

-- Departamentos (el jefe se asigna al final del script)
INSERT INTO departments VALUES (10, 'Administracion', NULL, 1400);
INSERT INTO departments VALUES (20, 'Mercadeo', NULL, 1000);
INSERT INTO departments VALUES (50, 'Logistica', NULL, 1100);
INSERT INTO departments VALUES (60, 'Tecnologia', NULL, 1000);
INSERT INTO departments VALUES (80, 'Ventas', NULL, 1300);
INSERT INTO departments VALUES (90, 'Direccion', NULL, 1400);
INSERT INTO departments VALUES (110, 'Contabilidad', NULL, 1400);
INSERT INTO departments VALUES (190, 'Compras', NULL, 1200);

-- Cargos
INSERT INTO jobs VALUES ('AD_PRES', 'Presidente', 20000, 40000);
INSERT INTO jobs VALUES ('AD_VP', 'Vicepresidente', 15000, 30000);
INSERT INTO jobs VALUES ('AD_ASST', 'Asistente administrativo', 3000, 6000);
INSERT INTO jobs VALUES ('MK_MAN', 'Gerente de mercadeo', 9000, 15000);
INSERT INTO jobs VALUES ('MK_REP', 'Representante de mercadeo', 4000, 9000);
INSERT INTO jobs VALUES ('IT_PROG', 'Programador', 4000, 10000);
INSERT INTO jobs VALUES ('ST_MAN', 'Jefe de bodega', 5500, 8500);
INSERT INTO jobs VALUES ('ST_CLERK', 'Auxiliar de bodega', 2000, 5000);
INSERT INTO jobs VALUES ('SA_MAN', 'Gerente de ventas', 10000, 20000);
INSERT INTO jobs VALUES ('SA_REP', 'Representante de ventas', 6000, 12000);
INSERT INTO jobs VALUES ('AC_MGR', 'Gerente contable', 8000, 16000);
INSERT INTO jobs VALUES ('AC_ACCOUNT', 'Contador', 4000, 9000);

-- Empleados (cada jefe se inserta antes que sus subordinados)
INSERT INTO employees VALUES (100, 'Andres', 'Gomez', 'AGOMEZ', '601.555.0100', TO_DATE('17/06/2015', 'DD/MM/YYYY'), 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO employees VALUES (101, 'Laura', 'Martinez', 'LMARTINEZ', '601.555.0101', TO_DATE('21/09/2016', 'DD/MM/YYYY'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO employees VALUES (102, 'Carlos', 'Ramirez', 'CRAMIREZ', '601.555.0102', TO_DATE('13/01/2017', 'DD/MM/YYYY'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO employees VALUES (103, 'Diana', 'Torres', 'DTORRES', '601.555.0103', TO_DATE('03/01/2018', 'DD/MM/YYYY'), 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO employees VALUES (104, 'Felipe', 'Castro', 'FCASTRO', '601.555.0104', TO_DATE('21/05/2019', 'DD/MM/YYYY'), 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO employees VALUES (107, 'Sofia', 'Herrera', 'SHERRERA', '601.555.0107', TO_DATE('07/02/2021', 'DD/MM/YYYY'), 'IT_PROG', 4200, NULL, 103, 60);
INSERT INTO employees VALUES (124, 'Jorge', 'Molina', 'JMOLINA', '604.555.0124', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 'ST_MAN', 5800, NULL, 100, 50);
INSERT INTO employees VALUES (141, 'Camila', 'Rios', 'CRIOS', '604.555.0141', TO_DATE('17/10/2020', 'DD/MM/YYYY'), 'ST_CLERK', 3500, NULL, 124, 50);
INSERT INTO employees VALUES (142, 'Mateo', 'Vargas', 'MVARGAS', '604.555.0142', TO_DATE('29/01/2022', 'DD/MM/YYYY'), 'ST_CLERK', 3100, NULL, 124, 50);
INSERT INTO employees VALUES (143, 'Valentina', 'Ortiz', 'VORTIZ', '604.555.0143', TO_DATE('15/03/2023', 'DD/MM/YYYY'), 'ST_CLERK', 2600, NULL, 124, 50);
INSERT INTO employees VALUES (144, 'Santiago', 'Pena', 'SPENA', '604.555.0144', TO_DATE('09/07/2023', 'DD/MM/YYYY'), 'ST_CLERK', 2500, NULL, 124, 50);
INSERT INTO employees VALUES (149, 'Natalia', 'Suarez', 'NSUAREZ', '91.555.0149', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 'SA_MAN', 10500, 0.2, 100, 80);
INSERT INTO employees VALUES (174, 'Daniel', 'Moreno', 'DMORENO', '91.555.0174', TO_DATE('11/05/2018', 'DD/MM/YYYY'), 'SA_REP', 11000, 0.3, 149, 80);
INSERT INTO employees VALUES (176, 'Isabella', 'Cruz', 'ICRUZ', '91.555.0176', TO_DATE('24/03/2019', 'DD/MM/YYYY'), 'SA_REP', 8600, 0.2, 149, 80);
INSERT INTO employees VALUES (178, 'Sebastian', 'Diaz', 'SDIAZ', '91.555.0178', TO_DATE('24/05/2021', 'DD/MM/YYYY'), 'SA_REP', 7000, 0.15, 149, NULL);
INSERT INTO employees VALUES (200, 'Paula', 'Mendoza', 'PMENDOZA', '206.555.0200', TO_DATE('17/09/2017', 'DD/MM/YYYY'), 'AD_ASST', 4400, NULL, 101, 10);
INSERT INTO employees VALUES (201, 'Miguel', 'Navarro', 'MNAVARRO', '601.555.0201', TO_DATE('17/02/2018', 'DD/MM/YYYY'), 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO employees VALUES (202, 'Lucia', 'Reyes', 'LREYES', '601.555.0202', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 'MK_REP', 6000, NULL, 201, 20);
INSERT INTO employees VALUES (205, 'Ricardo', 'Silva', 'RSILVA', '206.555.0205', TO_DATE('07/06/2016', 'DD/MM/YYYY'), 'AC_MGR', 12008, NULL, 101, 110);
INSERT INTO employees VALUES (206, 'Juliana', 'Pardo', 'JPARDO', '206.555.0206', TO_DATE('07/06/2016', 'DD/MM/YYYY'), 'AC_ACCOUNT', 8300, NULL, 205, 110);

-- Historial de cargos anteriores
INSERT INTO job_history VALUES (101, TO_DATE('21/09/2010', 'DD/MM/YYYY'), TO_DATE('27/10/2014', 'DD/MM/YYYY'), 'AC_ACCOUNT', 110);
INSERT INTO job_history VALUES (101, TO_DATE('28/10/2014', 'DD/MM/YYYY'), TO_DATE('20/09/2016', 'DD/MM/YYYY'), 'AC_MGR', 110);
INSERT INTO job_history VALUES (102, TO_DATE('13/01/2012', 'DD/MM/YYYY'), TO_DATE('12/01/2017', 'DD/MM/YYYY'), 'IT_PROG', 60);
INSERT INTO job_history VALUES (176, TO_DATE('24/03/2017', 'DD/MM/YYYY'), TO_DATE('31/12/2018', 'DD/MM/YYYY'), 'SA_REP', 80);
INSERT INTO job_history VALUES (176, TO_DATE('01/01/2019', 'DD/MM/YYYY'), TO_DATE('23/03/2019', 'DD/MM/YYYY'), 'SA_MAN', 80);
INSERT INTO job_history VALUES (200, TO_DATE('17/09/2010', 'DD/MM/YYYY'), TO_DATE('17/06/2016', 'DD/MM/YYYY'), 'AD_ASST', 90);
INSERT INTO job_history VALUES (200, TO_DATE('01/07/2016', 'DD/MM/YYYY'), TO_DATE('16/09/2017', 'DD/MM/YYYY'), 'AC_ACCOUNT', 90);
INSERT INTO job_history VALUES (201, TO_DATE('17/02/2014', 'DD/MM/YYYY'), TO_DATE('16/02/2018', 'DD/MM/YYYY'), 'MK_REP', 20);

-- Escalas salariales
INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

-- Jefe de cada departamento (Compras queda sin jefe y sin empleados)
UPDATE departments SET manager_id = 200 WHERE department_id = 10;
UPDATE departments SET manager_id = 201 WHERE department_id = 20;
UPDATE departments SET manager_id = 124 WHERE department_id = 50;
UPDATE departments SET manager_id = 103 WHERE department_id = 60;
UPDATE departments SET manager_id = 149 WHERE department_id = 80;
UPDATE departments SET manager_id = 100 WHERE department_id = 90;
UPDATE departments SET manager_id = 205 WHERE department_id = 110;

COMMIT;
```

### 3. Presentación 2: Recuperar datos con SELECT

[03_consultas.sql](/assets/sql/03_consultas.sql) · Consultas sobre una sola tabla: todas las columnas, cálculos con alias, concatenación y valores sin repetir.

#### Mostrar todos los departamentos <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">SELECT *</span>

```sql
SELECT *
FROM departments;
```

#### Salario mensual y anual de cada empleado <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Expresiones aritméticas y alias</span>

```sql
SELECT last_name, salary, salary * 12 AS "Salario anual"
FROM employees;
```

#### Nombre completo de cada empleado con su cargo <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Concatenación</span>

```sql
SELECT first_name || ' ' || last_name AS "Empleado", job_id
FROM employees;
```

#### Cargos que existen hoy en la empresa, sin repetir <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">DISTINCT</span>

```sql
SELECT DISTINCT job_id
FROM employees;
```

### 4. Presentación 3: Restringir y ordenar los datos

[03_consultas.sql](/assets/sql/03_consultas.sql) · Filtros con WHERE y sus operadores, ordenamiento y límite de filas.

#### Empleados del departamento de Tecnología <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">WHERE</span>

```sql
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE department_id = 60;
```

#### Empleados que ganan entre 5000 y 10000, del mayor al menor salario <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">BETWEEN y ORDER BY</span>

```sql
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 10000
ORDER BY salary DESC;
```

#### Empleados cuyo apellido tiene la letra a en la segunda posición <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">LIKE</span>

```sql
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '_a%';
```

#### Los cinco salarios más altos de la empresa <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">FETCH FIRST</span>

```sql
SELECT last_name, job_id, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;
```

### 5. Presentación 4: Funciones de una sola fila

[03_consultas.sql](/assets/sql/03_consultas.sql) · Funciones de caracteres, números y fechas que devuelven un resultado por cada fila.

#### Apellido en mayúsculas, nombre con inicial mayúscula y correo en minúsculas <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">UPPER, INITCAP, LOWER</span>

```sql
SELECT UPPER(last_name) AS apellido, INITCAP(first_name) AS nombre,
       LOWER(email) AS correo
FROM employees;
```

#### Iniciales y cantidad de letras del apellido de cada empleado <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">CONCAT, SUBSTR, LENGTH</span>

```sql
SELECT first_name, last_name,
       CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 1)) AS iniciales,
       LENGTH(last_name) AS letras_apellido
FROM employees;
```

#### Pago diario aproximado de los empleados de Logística <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">ROUND y TRUNC</span>

```sql
SELECT last_name, salary, ROUND(salary / 30, 2) AS pago_diario,
       TRUNC(salary / 30) AS pago_diario_entero
FROM employees
WHERE department_id = 50;
```

#### Meses trabajados y fin del periodo de prueba de los programadores <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">MONTHS_BETWEEN y ADD_MONTHS</span>

```sql
SELECT last_name, hire_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS meses_trabajados,
       ADD_MONTHS(hire_date, 6) AS fin_periodo_prueba
FROM employees
WHERE job_id = 'IT_PROG';
```

### 6. Presentación 5: Funciones de conversión y expresiones condicionales

[03_consultas.sql](/assets/sql/03_consultas.sql) · Conversión entre fechas, números y texto, manejo de valores nulos y condiciones dentro del SELECT.

#### Fecha de ingreso y salario con formato <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">TO_CHAR</span>

```sql
SELECT last_name, TO_CHAR(hire_date, 'DD/MM/YYYY') AS fecha_ingreso,
       TO_CHAR(salary, '$99,999.00') AS salario
FROM employees;
```

#### Empleados que ingresaron después del 1 de enero de 2021 <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">TO_DATE</span>

```sql
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01/01/2021', 'DD/MM/YYYY');
```

#### Comisión de cada empleado, mostrando 0 cuando no tiene <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">NVL y NVL2</span>

```sql
SELECT last_name, NVL(commission_pct, 0) AS comision,
       NVL2(commission_pct, 'Con comision', 'Sin comision') AS tipo_pago
FROM employees;
```

#### Nivel salarial de cada empleado según su salario <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">CASE</span>

```sql
SELECT last_name, salary,
       CASE WHEN salary < 5000 THEN 'Bajo'
            WHEN salary < 10000 THEN 'Medio'
            ELSE 'Alto'
       END AS nivel_salarial
FROM employees;
```

### 7. Presentación 6: Datos agregados con funciones de grupo

[03_consultas.sql](/assets/sql/03_consultas.sql) · Funciones que resumen varias filas en un solo resultado, agrupamiento y filtro de grupos.

#### Salario promedio, máximo, mínimo y total de la empresa <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">AVG, MAX, MIN, SUM</span>

```sql
SELECT ROUND(AVG(salary), 2) AS promedio, MAX(salary) AS maximo,
       MIN(salary) AS minimo, SUM(salary) AS total
FROM employees;
```

#### Cuántos empleados hay, cuántos tienen comisión y en cuántos departamentos trabajan <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">COUNT</span>

```sql
SELECT COUNT(*) AS empleados, COUNT(commission_pct) AS con_comision,
       COUNT(DISTINCT department_id) AS departamentos
FROM employees;
```

#### Cantidad de empleados y salario promedio por departamento <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">GROUP BY</span>

```sql
SELECT department_id, COUNT(*) AS empleados, ROUND(AVG(salary), 2) AS salario_promedio
FROM employees
GROUP BY department_id
ORDER BY department_id;
```

#### Departamentos cuyo salario máximo supera 10000 <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">HAVING</span>

```sql
SELECT department_id, MAX(salary) AS salario_maximo
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;
```

### 8. Presentación 7: Mostrar datos de varias tablas con JOIN

[03_consultas.sql](/assets/sql/03_consultas.sql) · Consultas que combinan tablas por sus llaves, por un rango de valores o con la misma tabla.

#### Empleado, departamento y ciudad donde trabaja <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">JOIN ON</span>

```sql
SELECT e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
```

#### Cada empleado junto al nombre de su jefe directo <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Self join</span>

```sql
SELECT e.last_name AS empleado, j.last_name AS jefe
FROM employees e
JOIN employees j ON e.manager_id = j.employee_id;
```

#### Escala salarial de cada empleado según su salario <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Nonequijoin</span>

```sql
SELECT e.last_name, e.salary, g.grade_level
FROM employees e
JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;
```

#### Todos los departamentos con sus empleados, incluso los que no tienen empleados <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">LEFT OUTER JOIN</span>

```sql
SELECT d.department_name, e.last_name
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name;
```

### 9. Presentación 8: Subconsultas

[03_consultas.sql](/assets/sql/03_consultas.sql) · Consultas que usan el resultado de otra consulta para filtrar los datos.

#### Empleados que ganan más que Castro <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Subconsulta de una fila</span>

```sql
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Castro');
```

#### Empleados que ganan el salario más bajo de la empresa <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Función de grupo en subconsulta</span>

```sql
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);
```

#### Departamentos cuyo salario mínimo es mayor que el mínimo del departamento 50 <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">HAVING con subconsulta</span>

```sql
SELECT department_id, MIN(salary) AS salario_minimo
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM employees
                      WHERE department_id = 50);
```

#### Empleados que trabajan en departamentos ubicados en Bogotá <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Subconsulta de varias filas</span>

```sql
SELECT last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id = 1000);
```

### 10. Presentación 9: Operadores de conjunto

[03_consultas.sql](/assets/sql/03_consultas.sql) · Combinación del cargo actual de cada empleado (EMPLOYEES) con sus cargos anteriores (JOB_HISTORY).

#### Todos los cargos que ha tenido cada empleado, sin repetir <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">UNION</span>

```sql
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history;
```

#### Los mismos cargos con su departamento, sin quitar los repetidos <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">UNION ALL</span>

```sql
SELECT employee_id, job_id, department_id
FROM employees
UNION ALL
SELECT employee_id, job_id, department_id
FROM job_history
ORDER BY employee_id;
```

#### Empleados que hoy tienen un cargo que ya habían tenido antes <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">INTERSECT</span>

```sql
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;
```

#### Empleados que nunca han cambiado de cargo <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">MINUS</span>

```sql
SELECT employee_id
FROM employees
MINUS
SELECT employee_id
FROM job_history;
```
