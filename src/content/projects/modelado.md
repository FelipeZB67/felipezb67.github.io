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

![Modelo entidad relación del torneo](/assets/img/torneo.jpg)

[Ver el modelo en Draw.io](https://viewer.diagrams.net/?lightbox=1&nav=1&title=Torneo.drawio#Uhttps%3A%2F%2Ffelipezb67.github.io%2Fassets%2Fdrawio%2Ftorneo.drawio)

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

![Modelo entidad relación de la plataforma](/assets/img/plataforma.jpg)

[Ver el modelo en Draw.io](https://viewer.diagrams.net/?lightbox=1&nav=1&title=Plataforma.drawio#Uhttps%3A%2F%2Ffelipezb67.github.io%2Fassets%2Fdrawio%2Fplataforma.drawio)

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

![Modelo entidad relación de la veterinaria](/assets/img/veterinaria.svg)

[Ver el modelo en Draw.io](https://viewer.diagrams.net/?lightbox=1&nav=1&title=Veterinaria.drawio#Uhttps%3A%2F%2Ffelipezb67.github.io%2Fassets%2Fdrawio%2Fveterinaria.drawio)

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

![Modelo entidad relación extendido del cinema](/assets/img/cinema.svg)

[Ver el modelo en Draw.io](https://viewer.diagrams.net/?lightbox=1&nav=1&title=Cinema.drawio#Uhttps%3A%2F%2Ffelipezb67.github.io%2Fassets%2Fdrawio%2Fcinema.drawio)

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

![Modelo entidad relación extendido del colegio](/assets/img/colegio.svg)

[Ver el modelo en Draw.io](https://viewer.diagrams.net/?lightbox=1&nav=1&title=Colegio.drawio#Uhttps%3A%2F%2Ffelipezb67.github.io%2Fassets%2Fdrawio%2Fcolegio.drawio)

#### Supuestos

1. Todo funcionario es docente, directivo o ambos. La jerarquía es solapada y total.
2. Todo espacio es aula o laboratorio, nunca las dos cosas. La jerarquía es exclusiva y total.
3. Un docente dicta varias asignaturas y una asignatura la pueden dictar varios docentes. Cada una de esas clases ocupa un espacio en un horario.
4. Cada curso tiene un docente director y un docente dirige como máximo un curso.
5. Cada estudiante pertenece a un solo curso y un curso tiene como máximo 40 estudiantes.
6. Las observaciones dependen del estudiante: su número se repite entre estudiantes distintos, por eso OBSERVACION es una entidad débil.
7. Una asignatura puede ser requisito de otras asignaturas.
8. La edad del funcionario no se guarda, se calcula con su fecha de nacimiento.
