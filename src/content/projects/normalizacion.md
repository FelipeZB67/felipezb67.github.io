---
title: Normalización
description: Evidencias del proceso de normalización de bases de datos.
category: Evidencias
importance: 2
---

## Normalización

Aquí están los tres documentos de esta parte del curso: el taller de normalización, la resolución del taller de reducción a tablas y la normalización de esas tablas. En la normalización se revisan las formas normales en orden, desde la primera hasta la quinta (1FN, 2FN, 3FN, BCNF, 4FN y 5FN), explicando paso a paso qué condición se revisa y por qué se cumple o no.

### Taller de normalización

Taller hecho con Juan Felipe Lizarazo Prieto. Analiza tres esquemas de una sola tabla: la hospitalización de pacientes, los pedidos de una tienda y las competencias e idiomas de los empleados.

#### Enunciado

A partir de cada esquema se pide identificar sus dependencias funcionales y su clave, decir en qué forma normal está, analizar las anomalías de inserción, actualización y eliminación que produce, normalizarlo paso a paso, comparar la 3FN con la BCNF y, en el caso de los empleados, decidir si conviene guardar las competencias en una columna de texto o en tablas separadas.

**Objetivo de aprendizaje:** Reconocer dependencias parciales, transitivas y multivaluadas, y descomponer cada esquema hasta la 5FN sin perder información.

[Ver el taller de normalización (PDF)](/assets/pdf/normalizacion/taller-normalizacion.pdf)

#### Resultado

1. Hospitalización: el esquema original solo estaba en 1FN y queda en 5FN con cuatro tablas: PACIENTE, CAMA, MEDICO y ATENCION.
2. Pedidos: también estaba solo en 1FN y queda en 5FN con cinco tablas: CLIENTE, VENDEDOR, PRODUCTO, PEDIDO y DETALLE_PEDIDO.
3. Empleado: no cumplía la 1FN y es el caso que muestra la 4FN, porque las competencias y los idiomas son dos listas independientes que deben ir en tablas separadas.

### Taller de reducción a tablas

Este taller parte de dos modelos entidad relación, el de una librería y el de un zoológico, y los convierte en tablas con sus claves primarias y foráneas. Es el paso previo a normalizar.

#### Enunciado

A partir de los dos diagramas del taller se pide leer sus entidades, atributos, claves y relaciones, y reducirlos a tablas aplicando las reglas vistas en clase, indicando en cada tabla su clave primaria y sus claves foráneas.

**Objetivo de aprendizaje:** Aplicar las reglas de reducción según la cardinalidad de cada relación: las relaciones 1:N se resuelven con una clave foránea y las N:M con una tabla intermedia que guarda también sus atributos propios.

[Ver el taller de reducción a tablas (PDF)](/assets/pdf/normalizacion/taller-reduccion-tablas.pdf)

#### Resultado

1. Librería: 11 tablas, 6 de entidades y 5 tablas intermedias, porque todas sus relaciones son N:M.
2. Zoológico: 12 tablas, 7 de entidades y 5 intermedias. La relación entre especie y zona es 1:N y se resuelve con una clave foránea en ESPECIE.
3. Las tablas se crean en orden: primero las que no tienen claves foráneas y al final las intermedias.

### Normalización del taller de reducción a tablas

Este documento toma las tablas que salieron al reducir los modelos entidad relación de una librería y de un zoológico, y comprueba que cumplan la 5FN.

#### Enunciado

Partiendo de las 11 tablas de la librería y las 12 del zoológico, se pide escribir las dependencias funcionales de cada tabla, revisar las formas normales en orden y dejar claros los supuestos de los que depende el resultado.

**Objetivo de aprendizaje:** Verificar que una reducción a tablas bien hecha ya queda normalizada, y entender qué decisiones de diseño y qué supuestos sobre los datos podrían romper alguna forma normal.

[Ver la normalización del taller de reducción a tablas (PDF)](/assets/pdf/normalizacion/normalizacion-reduccion-tablas.pdf)

#### Resultado

1. Librería: las 11 tablas quedan en 5FN sin cambios.
2. Zoológico: las 12 tablas quedan en 5FN sin cambios.
3. Los supuestos que sostienen el resultado son que teléfonos y direcciones guardan un solo valor, que la URL pertenece al autor completo y que todas las relaciones son binarias.
