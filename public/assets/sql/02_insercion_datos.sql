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
