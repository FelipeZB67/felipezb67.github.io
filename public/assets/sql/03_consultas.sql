-- Consultas sobre el esquema HR, organizadas por las presentaciones del curso.
-- Ejecutar despues de 02_insercion_datos.sql. Cada consulta se puede correr sola con Ctrl+Enter.

-- ============================================================================
-- Presentacion 2: Recuperar datos con la sentencia SELECT
-- ============================================================================

-- Mostrar todos los departamentos
SELECT *
FROM departments;

-- Salario mensual y anual de cada empleado
SELECT last_name, salary, salary * 12 AS "Salario anual"
FROM employees;

-- Nombre completo de cada empleado con su cargo
SELECT first_name || ' ' || last_name AS "Empleado", job_id
FROM employees;

-- Cargos que existen hoy en la empresa, sin repetir
SELECT DISTINCT job_id
FROM employees;

-- ============================================================================
-- Presentacion 3: Restringir y ordenar los datos
-- ============================================================================

-- Empleados del departamento de Tecnologia
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE department_id = 60;

-- Empleados que ganan entre 5000 y 10000, del mayor al menor salario
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 10000
ORDER BY salary DESC;

-- Empleados cuyo apellido tiene la letra a en la segunda posicion
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '_a%';

-- Los cinco salarios mas altos de la empresa
SELECT last_name, job_id, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;

-- ============================================================================
-- Presentacion 4: Funciones de una sola fila
-- ============================================================================

-- Apellido en mayusculas, nombre con inicial mayuscula y correo en minusculas
SELECT UPPER(last_name) AS apellido, INITCAP(first_name) AS nombre,
       LOWER(email) AS correo
FROM employees;

-- Iniciales y cantidad de letras del apellido de cada empleado
SELECT first_name, last_name,
       CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 1)) AS iniciales,
       LENGTH(last_name) AS letras_apellido
FROM employees;

-- Pago diario aproximado de los empleados de Logistica, redondeado a dos decimales
SELECT last_name, salary, ROUND(salary / 30, 2) AS pago_diario,
       TRUNC(salary / 30) AS pago_diario_entero
FROM employees
WHERE department_id = 50;

-- Meses trabajados y fin del periodo de prueba de los programadores
SELECT last_name, hire_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS meses_trabajados,
       ADD_MONTHS(hire_date, 6) AS fin_periodo_prueba
FROM employees
WHERE job_id = 'IT_PROG';

-- ============================================================================
-- Presentacion 5: Funciones de conversion y expresiones condicionales
-- ============================================================================

-- Fecha de ingreso y salario con formato
SELECT last_name, TO_CHAR(hire_date, 'DD/MM/YYYY') AS fecha_ingreso,
       TO_CHAR(salary, '$99,999.00') AS salario
FROM employees;

-- Empleados que ingresaron despues del 1 de enero de 2021
SELECT last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01/01/2021', 'DD/MM/YYYY');

-- Comision de cada empleado, mostrando 0 cuando no tiene
SELECT last_name, NVL(commission_pct, 0) AS comision,
       NVL2(commission_pct, 'Con comision', 'Sin comision') AS tipo_pago
FROM employees;

-- Nivel salarial de cada empleado segun su salario
SELECT last_name, salary,
       CASE WHEN salary < 5000 THEN 'Bajo'
            WHEN salary < 10000 THEN 'Medio'
            ELSE 'Alto'
       END AS nivel_salarial
FROM employees;

-- ============================================================================
-- Presentacion 6: Datos agregados con funciones de grupo
-- ============================================================================

-- Salario promedio, maximo, minimo y total de la empresa
SELECT ROUND(AVG(salary), 2) AS promedio, MAX(salary) AS maximo,
       MIN(salary) AS minimo, SUM(salary) AS total
FROM employees;

-- Cuantos empleados hay, cuantos tienen comision y en cuantos departamentos trabajan
SELECT COUNT(*) AS empleados, COUNT(commission_pct) AS con_comision,
       COUNT(DISTINCT department_id) AS departamentos
FROM employees;

-- Cantidad de empleados y salario promedio por departamento
SELECT department_id, COUNT(*) AS empleados, ROUND(AVG(salary), 2) AS salario_promedio
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- Departamentos cuyo salario maximo supera 10000
SELECT department_id, MAX(salary) AS salario_maximo
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

-- ============================================================================
-- Presentacion 7: Mostrar datos de varias tablas con JOIN
-- ============================================================================

-- Empleado, departamento y ciudad donde trabaja
SELECT e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

-- Cada empleado junto al nombre de su jefe directo
SELECT e.last_name AS empleado, j.last_name AS jefe
FROM employees e
JOIN employees j ON e.manager_id = j.employee_id;

-- Escala salarial de cada empleado segun su salario
SELECT e.last_name, e.salary, g.grade_level
FROM employees e
JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- Todos los departamentos con sus empleados, incluso los que no tienen empleados
SELECT d.department_name, e.last_name
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name;

-- ============================================================================
-- Presentacion 8: Subconsultas
-- ============================================================================

-- Empleados que ganan mas que Castro
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Castro');

-- Empleados que ganan el salario mas bajo de la empresa
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);

-- Departamentos cuyo salario minimo es mayor que el minimo del departamento 50
SELECT department_id, MIN(salary) AS salario_minimo
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM employees
                      WHERE department_id = 50);

-- Empleados que trabajan en departamentos ubicados en Bogota
SELECT last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id = 1000);

-- ============================================================================
-- Presentacion 9: Operadores de conjunto
-- ============================================================================

-- Todos los cargos que ha tenido cada empleado, el actual y los anteriores, sin repetir
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history;

-- Los mismos cargos con su departamento, sin quitar los repetidos
SELECT employee_id, job_id, department_id
FROM employees
UNION ALL
SELECT employee_id, job_id, department_id
FROM job_history
ORDER BY employee_id;

-- Empleados que hoy tienen un cargo que ya habian tenido antes
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

-- Empleados que nunca han cambiado de cargo
SELECT employee_id
FROM employees
MINUS
SELECT employee_id
FROM job_history;
