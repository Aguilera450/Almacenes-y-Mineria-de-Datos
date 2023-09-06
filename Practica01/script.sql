/* Vista para la tabla empleado con el CURP y nombre completo */
CREATE VIEW vista_empleados
as select curp, nombre, paterno, materno 
from Empleado
WHERE nombre LIKE 'A%';

/* Consultando vista_empleados */
SELECT * FROM vista_empleados;

/* Insertando datos */
INSERT INTO vista_empleados (curp, nombre, paterno, materno)
VALUES ('AIHD674006HIMTWX73', 'Adonis', 'Hernandez', 'Dorantes');

/* Eliminando datos */
DELETE FROM vista_empleados WHERE nombre='Adriaens';

/* Actualizando datos */
UPDATE vista_empleados
SET nombre='Andrea', materno='Flores'
WHERE curp='DCSW398174HTBEHJ30';


/* Vista con toda la informacion de los empleados y departamentos */
CREATE VIEW vista_empleados_departamentos
as select e.curp, e.nombre, e.paterno, e.materno, e.salario,
e.genero, e.nacimiento, e.ciudad, e.calle, e.cp, d.numDepto,
d.nombreDepto, d.fecha
from Empleado e 
join Departamento d
on e.numDepto=d.numDepto;

/* Consultando vista_empleados_departamentos */
SELECT * FROM vista_empleados_departamentos;

/* Insertando datos */
INSERT INTO vista_empleados_departamentos(curp, nombre, paterno, materno, salario, genero,
nacimiento, ciudad, calle, cp, numDepto, nombreDepto, fecha)
VALUES ('TLGN333664HDBVKQ20', 274, 'Amalie', 'Vernazza', 'Edelheid', 87959, 'F', '30/06/1978', 'Zac', 'Hovde', 74968, 'Gembucket', '02/08/2022');

/* Eliminando datos */
DELETE FROM vista_empleados_departamentos WHERE curp='QORI674750HNEFSQ17';

/* Actualizando datos */
UPDATE vista_empleados_departamentos
SET nombre='Ken', salario=90077, cp=34781
WHERE curp='VYQH311652HMEJDK28';


/* Vista que muestra numProyecto, nombreProyecto, el numero de empleados y el
numero de horas colaboradas de cada proyecto */
CREATE VIEW vista_proyecto_empleados
as select p.numProy, p.nombreProy, 
count(c.curp) as empleadosEnProyecto,
sum(c.numHoras) as horasColaboradas
from Colaborar c
join Proyecto p
on c.numProy=p.numProy
group by p.numProy, p.nombreProy;

/* Consultando vista_proyecto_empleados */
SELECT * FROM vista_proyecto_empleados;

/* Insertando datos */
INSERT INTO vista_proyecto_empleados(numProy, nombreProy, empleadosEnProyecto, horasColaboradas)
VALUES (1, 'Almacen', 3, 1223);

/* Eliminando datos */
DELETE FROM vista_proyecto_empleados WHERE nombreProy='Voltsillam';

/* Actualizando datos */
UPDATE vista_proyecto_empleados
SET nombreProy='Mineria', empleadosEnProyecto=5
WHERE numProy=1;




/* Vista Materializada para la tabla empleado con el CURP y nombre completo */
CREATE VIEW vm_empleados WITH SCHEMABINDING
AS select curp, nombre, paterno, materno 
from dbo.Empleado
WHERE nombre LIKE 'A%';	

/* Consultando vm_empleados */
SELECT * FROM vm_empleados;


/* Vista Materializada con toda la informacion de los empleados y departamentos */
CREATE VIEW vm_empleados_departamentos WITH SCHEMABINDING
as select e.curp, e.nombre, e.paterno, e.materno, e.salario,
e.genero, e.nacimiento, e.ciudad, e.calle, e.cp, d.numDepto,
d.nombreDepto, d.fecha
from dbo.Empleado e 
join dbo.Departamento d
on e.numDepto=d.numDepto;

/* Consultando vm_empleados_departamentos */
SELECT * FROM vm_empleados_departamentos;

/* Vista Materializada que muestra numProyecto, nombreProyecto, el numero de empleados y el
numero de horas colaboradas de cada proyecto */
CREATE VIEW vm_vista_proyecto_empleados WITH SCHEMABINDING
as select p.numProy, p.nombreProy, 
count(c.curp) as empleadosEnProyecto,
sum(c.numHoras) as horasColaboradas
from dbo.Colaborar c
join dbo.Proyecto p
on c.numProy=p.numProy
group by p.numProy, p.nombreProy;

/* Consultando vm_vista_proyecto_empleados */
SELECT * FROM vm_vista_proyecto_empleados;
