---
title: SQL
description: Consultas en Oracle sobre el esquema HR, organizadas por las presentaciones de SQL del curso.
category: Evidencias
importance: 3
---

## SQL

[Descargar consultas .sql (ZIP)](/assets/sql/consultas_sql_hr.zip)

Estas consultas se hicieron sobre el esquema HR (Recursos Humanos) que se usa en las presentaciones de SQL del curso: empleados, departamentos, cargos, sedes, países y regiones. Están organizadas por presentación, desde la 2 hasta la 9, y cada una indica el tema que practica.

Están escritas para Oracle Database y se ejecutan desde Oracle SQL Developer sobre el esquema HR ya creado. Cada consulta se puede correr sola con Ctrl+Enter.

**Objetivo de aprendizaje:** Consultar una base de datos en Oracle con todo lo visto en las presentaciones: filtros, funciones de una fila, conversiones, funciones de grupo, JOIN, subconsultas y operadores de conjunto.

<div style="display:flex;flex-wrap:wrap;gap:0.75rem;margin:1.5rem 0;"><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">32</div><div style="font-size:0.75rem;letter-spacing:0.08em;">CONSULTAS</div></div><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">8</div><div style="font-size:0.75rem;letter-spacing:0.08em;">PRESENTACIONES</div></div><div style="flex:1 1 7rem;padding:0.9rem;border:1px solid var(--global-divider-color);border-radius:8px;text-align:center;"><div style="font-size:1.8rem;font-weight:700;color:var(--global-theme-color);">5</div><div style="font-size:0.75rem;letter-spacing:0.08em;">TABLAS CONSULTADAS</div></div></div>

### Presentación 2: Recuperar datos con SELECT

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

### Presentación 3: Restringir y ordenar los datos

[03_consultas.sql](/assets/sql/03_consultas.sql) · Filtros con WHERE y sus operadores, ordenamiento y límite de filas.

#### Empleados del departamento de IT <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">WHERE</span>

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

### Presentación 4: Funciones de una sola fila

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

#### Pago diario aproximado de los empleados de Shipping <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">ROUND y TRUNC</span>

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

### Presentación 5: Funciones de conversión y expresiones condicionales

[03_consultas.sql](/assets/sql/03_consultas.sql) · Conversión entre fechas, números y texto, manejo de valores nulos y condiciones dentro del SELECT.

#### Fecha de ingreso y salario con formato <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">TO_CHAR</span>

```sql
SELECT last_name, TO_CHAR(hire_date, 'DD/MM/YYYY') AS fecha_ingreso,
       TO_CHAR(salary, '$99,999.00') AS salario
FROM employees;
```

#### Empleados que ingresaron después del 1 de enero de 2017 <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">TO_DATE</span>

```sql
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01/01/2017', 'DD/MM/YYYY');
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

### Presentación 6: Datos agregados con funciones de grupo

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

### Presentación 7: Mostrar datos de varias tablas con JOIN

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

### Presentación 8: Subconsultas

[03_consultas.sql](/assets/sql/03_consultas.sql) · Consultas que usan el resultado de otra consulta para filtrar los datos.

#### Empleados que ganan más que Abel <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Subconsulta de una fila</span>

```sql
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Abel');
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

#### Empleados que trabajan en departamentos ubicados en Seattle <span style="display:inline-block;margin-left:0.5rem;padding:0.1rem 0.55rem;border-radius:999px;font-size:0.75rem;font-weight:600;vertical-align:middle;color:var(--global-theme-color);border:1px solid var(--global-theme-color);">Subconsulta de varias filas</span>

```sql
SELECT last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id = 1700);
```

### Presentación 9: Operadores de conjunto

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
