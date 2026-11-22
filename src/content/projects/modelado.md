---
title: Modelado
description: Diagramas entidad relación, modelos conceptuales y modelos lógicos del curso.
category: Evidencias
importance: 1
---

## Modelado de Datos

Aquí están los modelos entidad relación (MER) que desarrollé durante el curso. Cada uno tiene una explicación corta, los supuestos con los que lo construí y un enlace para abrirlo en Draw.io.

### Modelo: Torneo

Este modelo organiza un torneo de fútbol entre los programas académicos de la universidad. Cada programa inscribe equipos, los equipos están formados por jugadores y se enfrentan entre ellos en partidos. En cada partido se registran las tarjetas que recibe cada jugador.

#### Enunciado

La universidad organiza un torneo de fútbol entre sus programas académicos y necesita una base de datos para administrarlo. De cada programa se conoce su código, su nombre y su facultad. Cada programa inscribe equipos, de los que se guarda el código, el nombre, los colores del uniforme y el estado. Los jugadores se registran con su documento, nombre, apellido, semestre, jornada y fecha de nacimiento, y cada uno integra un equipo. Los equipos se enfrentan en partidos que tienen cancha, jornada, fecha, hora y estado, y de cada participación se registran los goles anotados y el rol del equipo. En los partidos se sacan tarjetas a los jugadores y de cada una se guarda el tipo, el minuto y el motivo.

**Objetivo de aprendizaje:** Aplicar la notación de Peter Chen con atributos clave, multivaluados y derivados, una relación N:M con atributos propios y una entidad débil que depende de una relación identificadora.

![Modelo entidad relación del torneo](/assets/img/torneo.jpg)

[Ver el modelo en Draw.io](/assets/drawio/torneo.html)

#### Supuestos

1. Un programa académico puede inscribir varios equipos, pero cada equipo pertenece a un solo programa.
2. Un equipo puede usar varios colores de uniforme, por eso color_uniforme es un atributo multivaluado.
3. Cada jugador integra un solo equipo y un equipo agrupa a varios jugadores.
4. Un equipo juega varios partidos y en cada partido participan varios equipos. Los goles anotados y el rol de cada equipo se guardan en esa participación, no en el equipo ni en el partido.
5. La edad del jugador no se guarda, se calcula con su fecha de nacimiento.
6. Una tarjeta no existe por sí sola: depende del partido en el que ocurre y del jugador que la recibe, por eso es una entidad débil.
7. De cada tarjeta se guarda el tipo, el minuto y el motivo.

### Modelo: Plataforma

Este modelo representa una plataforma de streaming. Los usuarios hacen búsquedas, ven contenidos y eligen las categorías que prefieren. Cada contenido pertenece a una o varias categorías y lo produce un productor.

#### Enunciado

Una plataforma de streaming necesita guardar la información de sus usuarios y de lo que ven. De cada usuario se conoce su documento, nombre, correo y sus métodos de pago. Los usuarios hacen búsquedas, de las que se guarda el texto y la fecha, y cada vez que ven algo se registra la fecha y el tiempo visto. Cada contenido tiene código IMDb, título, tipo, duración y año de lanzamiento, pertenece a una o varias categorías y lo produce un productor, del que se conoce su documento, nombre y país de origen. La plataforma también quiere saber qué categorías prefiere cada usuario y cuántas veces ha visto contenido de cada una.

**Objetivo de aprendizaje:** Practicar entidades débiles con sus relaciones identificadoras, atributos multivaluados y derivados, y la diferencia entre relaciones 1:N, N:1 y N:M.

![Modelo entidad relación de la plataforma](/assets/img/plataforma.jpg)

[Ver el modelo en Draw.io](/assets/drawio/plataforma.html)

#### Supuestos

1. Un usuario puede registrar varios métodos de pago, por eso metodo_de_pago es multivaluado.
2. Cada búsqueda la hace un solo usuario y solo tiene sentido junto a él, por eso BUSQUEDA es una entidad débil.
3. Cada visualización queda registrada para un usuario y corresponde a un solo contenido, mientras que un contenido puede tener muchas visualizaciones.
4. Un usuario puede preferir varias categorías y una categoría puede ser preferida por muchos usuarios.
5. Un contenido puede pertenecer a varias categorías y una categoría agrupa muchos contenidos.
6. Un productor puede producir varios contenidos, pero cada contenido tiene un solo productor.
7. veces_vista no se guarda: es un dato calculado que dice cuántas veces un usuario ha visto contenido de una categoría.

### Modelo: Veterinaria

Este modelo organiza la información de una clínica veterinaria: los clientes, sus mascotas, las consultas, las vacunas que se aplican y los veterinarios que atienden.

#### Enunciado

Una clínica veterinaria necesita una base de datos para su atención diaria. De los clientes se guarda el documento, el nombre, sus teléfonos y la dirección. Cada cliente tiene mascotas, de las que se conoce su identificador, nombre, especie y fecha de nacimiento. Las mascotas asisten a consultas con fecha y motivo, y cada consulta la atiende un veterinario. En las consultas se recetan medicamentos indicando la dosis y la frecuencia. También se registran las vacunas que recibe cada mascota, con el número de dosis, el nombre de la vacuna y la fecha de aplicación. Cada veterinario tiene un consultorio asignado y algunos veterinarios supervisan a otros.

**Objetivo de aprendizaje:** Usar todos los elementos del modelo entidad relación no extendido: atributos simples, compuestos, multivaluados, derivados y clave, cardinalidades 1:1, 1:N, N:1 y N:M, participación total y parcial, límites de cardinalidad, una relación recursiva con roles y una entidad débil.

![Modelo entidad relación de la veterinaria](/assets/img/veterinaria.svg)

[Ver el modelo en Draw.io](/assets/drawio/veterinaria.html)

#### Supuestos

1. Un cliente tiene una o varias mascotas y cada mascota tiene un solo dueño registrado.
2. Un cliente puede registrar varios teléfonos.
3. La edad de la mascota no se guarda, se calcula con su fecha de nacimiento.
4. Cada consulta corresponde a una sola mascota y la atiende un solo veterinario.
5. En una consulta se pueden recetar varios medicamentos y un medicamento aparece en muchas consultas. La dosis y la frecuencia dependen de cada receta.
6. La vacunación depende de la mascota: el número de dosis se repite entre mascotas distintas, por eso es una entidad débil.
7. Cada veterinario tiene asignado un consultorio y un consultorio puede quedar sin veterinario.
8. Un veterinario puede supervisar a otros veterinarios.

## Modelos entidad relación extendidos

### Modelo extendido: Cinema

Este modelo representa una cadena de cines con varias sedes. Incluye las salas, las películas que se proyectan, los boletos que se venden, los clientes y los empleados de cada sede.

#### Enunciado

Una cadena de cines con varias sedes quiere organizar su información. Cada sede tiene nombre, dirección y teléfonos, y cuenta con varias salas numeradas dentro de ella. En las salas se proyectan películas en una fecha y hora, y de cada película se guarda el código, el título, la duración y sus géneros. Cada proyección genera boletos con silla y precio, que compran los clientes. Algunos clientes son socios, con número de tarjeta y puntos, y otros son estudiantes, con su institución. Los empleados trabajan en una sede, algunos supervisan a otros, y entre ellos hay taquilleros y proyeccionistas. Cada proyeccionista opera una sala.

**Objetivo de aprendizaje:** Aplicar el modelo extendido con dos jerarquías ES, una exclusiva y otra solapada, ambas con participación parcial, y una agregación que genera los boletos, sin dejar de lado los elementos del modelo básico.

![Modelo entidad relación extendido del cinema](/assets/img/cinema.svg)

[Ver el modelo en Draw.io](/assets/drawio/cinema.html)

#### Supuestos

1. Cada sala pertenece a una sede y su número se repite entre sedes distintas, por eso SALA es una entidad débil.
2. Una sala proyecta muchas películas y una película se proyecta en muchas salas. La fecha y la hora pertenecen a cada proyección.
3. Cada boleto sale de una proyección concreta, por eso se relaciona con la agregación y no solo con la sala o con la película.
4. Un cliente puede comprar varios boletos y puede estar registrado sin haber comprado ninguno.
5. Un empleado puede ser taquillero o proyeccionista, nunca las dos cosas, y hay empleados que no son ninguno de los dos. La jerarquía es exclusiva y parcial.
6. Un cliente puede ser socio, estudiante o ambos, y también puede no ser ninguno. La jerarquía es solapada y parcial.
7. Cada proyeccionista opera una sola sala y cada sala tiene un solo proyeccionista.
8. Un empleado puede tener a cargo a otros empleados.

### Modelo extendido: Colegio

Este modelo representa un colegio: sus funcionarios, los cursos, los estudiantes, las asignaturas y los espacios donde se dictan las clases.

#### Enunciado

Un colegio necesita registrar a su personal, sus estudiantes y sus clases. Los funcionarios tienen identificador, nombre, teléfonos y fecha de nacimiento, y pueden ser docentes, con su especialidad, o directivos, con su cargo. Los docentes dictan asignaturas en un año lectivo y cada clase ocupa un espacio en un horario. Los espacios son aulas o laboratorios. Algunas asignaturas son requisito de otras. Cada curso tiene grado, jornada y un docente director, y los estudiantes pertenecen a un curso. De cada estudiante se registran observaciones con número, fecha y descripción.

**Objetivo de aprendizaje:** Aplicar el modelo extendido con dos jerarquías ES, una solapada y otra exclusiva, ambas con participación total, y una agregación que se relaciona con otra entidad, junto con los elementos del modelo básico.

![Modelo entidad relación extendido del colegio](/assets/img/colegio.svg)

[Ver el modelo en Draw.io](/assets/drawio/colegio.html)

#### Supuestos

1. Todo funcionario es docente, directivo o ambos. La jerarquía es solapada y total.
2. Todo espacio es aula o laboratorio, nunca las dos cosas. La jerarquía es exclusiva y total.
3. Un docente dicta varias asignaturas y una asignatura la pueden dictar varios docentes. Cada una de esas clases ocupa un espacio en un horario.
4. Cada curso tiene un docente director y un docente dirige como máximo un curso.
5. Cada estudiante pertenece a un solo curso y un curso tiene como máximo 40 estudiantes.
6. Las observaciones dependen del estudiante: su número se repite entre estudiantes distintos, por eso OBSERVACION es una entidad débil.
7. Una asignatura puede ser requisito de otras asignaturas.
8. La edad del funcionario no se guarda, se calcula con su fecha de nacimiento.
